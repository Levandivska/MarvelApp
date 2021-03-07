//
//  ViewController.swift
//  MarvelApp
//
//  Created by оля on 23.02.2021.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    static let sectionHeaderElementKind = "section-header-element-kind"

    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    private var fetchedComicsResultsController: NSFetchedResultsController<Comic>? = nil
        
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var network = Networker()
        
    var characters: [Character] = []
    var comics: [Comic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        creacteFetchedComicsResultsController()
        collectionView.collectionViewLayout = generateLayout()
        
        // fetch Character list from network
        network.fetchCharacters { [weak self] (charactersInfo) -> (Void) in
            guard let charactersInfo = charactersInfo else { return }
//            self?.charactersInfo = charactersInfo
            self?.updateDatabase(with: charactersInfo)

            //  for each character fetch comics
            charactersInfo.forEach{ [weak self] character in
                self?.network.fetchComics(characterId: character.id){ (comics) -> (Void) in
                    if let comics = comics {
                        self?.updateDatabase(with: comics)
                        self?.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    private func creacteFetchedComicsResultsController(){
        if let context = container?.viewContext {
            let request = NSFetchRequest<Comic>(entityName: "Comic")
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            self.fetchedComicsResultsController = NSFetchedResultsController<Comic>(
                   fetchRequest: request,
                   managedObjectContext: context,
                   sectionNameKeyPath: nil,
                   cacheName: nil
               )
            
            try? fetchedComicsResultsController?.performFetch()
                   collectionView.reloadData()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sections = fetchedComicsResultsController?.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.identifier,
                                                              for: indexPath) as! HomeCollectionCell
        cell.img.image = UIImage(systemName: "person")
        guard let object = fetchedComicsResultsController?.object(at: indexPath) else { return UICollectionViewCell() }
        cell.titleLabel.text = object.title
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let sections = fetchedComicsResultsController?.sections {
            return sections.count
        }
        return 0
    }
}

// core Data functions extension
extension HomeViewController{
    private func fetchComicsFromDatabase(){
        container?.performBackgroundTask {[weak self] context in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Comic")
            do {
                if let comics = try context.fetch(fetchRequest) as? [Comic]{
                    self?.comics = comics
                }
            }
            catch {
                fatalError("Failed to fetch Characters")
            }
        }
    }
    
    private func updateDatabase(with comicsInfo: [ComicInfo]){
        container?.performBackgroundTask{ [weak self] context in
            for comicInfo in comicsInfo {
                let comic = Comic.create(comicInfo: comicInfo, in: context)
//                print(comic.title!)
                self?.comics.append(comic)
            }
            try? context.save()
        }
    }

    private func updateDatabase(with charactersInfo: [CharacterInfo]){
        container?.performBackgroundTask{ context in
            for characterInfo in charactersInfo {
                _ = Character.create(characterInfo: characterInfo, in: context)
            }
            try? context.save()
        }
    }
}

// Compositional Layput extension
extension HomeViewController {
    func generateComicsLayout() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
//        let groupFractionalWidth = isWide ? 0.475 : 0.95
//        let groupFractionalHeight: Float = isWide ? 1/3 : 2/3
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.95),
            heightDimension: .fractionalWidth(1/3)
            )
        
        let group = NSCollectionLayoutGroup.horizontal(
           layoutSize: groupSize,
           subitem: item,
           count: 1)
        
        group.contentInsets = NSDirectionalEdgeInsets(
          top: 5,
          leading: 5,
          bottom: 5,
          trailing: 5)

        let headerSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .estimated(44))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: headerSize,
          elementKind: HomeViewController.sectionHeaderElementKind,
          alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous
//        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func generateLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
          layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in

          guard let sectionLayoutKind = HomeSections(rawValue: sectionIndex) else { fatalError("Not correct section index")}
          switch sectionLayoutKind {
          case .comics: return self.generateComicsLayout()
          case .events: return self.generateComicsLayout()
          }
        }
        
        return layout
    }
}
