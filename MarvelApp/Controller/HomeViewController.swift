//
//  ViewController.swift
//  MarvelApp
//
//  Created by оля on 23.02.2021.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    private var fetchedResultsController: NSFetchedResultsController<Item>? = nil
        
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var network = Networker()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        creacteFetchedResultsController()
        collectionView.collectionViewLayout = generateLayout()
        
        // fetch Character list from network
        network.fetchCharacters { [weak self] (charactersInfo) -> (Void) in
            guard let charactersInfo = charactersInfo else { return }
//            self?.charactersInfo = charactersInfo
            self?.updateDatabase(with: charactersInfo)

            //  for each character fetch items from network
            for character in charactersInfo {

                // fetch comics fromnetwork
                let comicsSection = HomeSections.comics.description
                self?.network.fetchItems(characterId: character.id, itemSection: comicsSection){ (items) -> (Void) in
                    if let items = items {
                        self?.updateDatabase(with: items, asType: comicsSection)
                        self?.collectionView.reloadData()
                    }
                }
                
                // fetch stories from network
                let storiesSection = HomeSections.stories.description
                self?.network.fetchItems(characterId: character.id, itemSection: storiesSection){ (items) -> (Void) in
                    if let items = items {
                        self?.updateDatabase(with: items, asType: storiesSection)
                        self?.collectionView.reloadData()
                    }
                }
                
                let eventsSection = HomeSections.stories.description
                self?.network.fetchItems(characterId: character.id, itemSection: eventsSection){ (items) -> (Void) in
                    if let items = items {
                        self?.updateDatabase(with: items, asType: eventsSection)
                        self?.collectionView.reloadData()
                    }
                }
                
                // fetch series from network
                let seriesSection = HomeSections.series.description
                self?.network.fetchItems(characterId: Int(character.id), itemSection: seriesSection){ (items) -> (Void) in
                    if let items = items {
                        self?.updateDatabase(with: items, asType: seriesSection)
                        self?.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    private func creacteFetchedResultsController(){
        if let context = container?.viewContext {
            let request = NSFetchRequest<Item>(entityName: "Item")
            request.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]

            self.fetchedResultsController = NSFetchedResultsController<Item>(
                   fetchRequest: request,
                   managedObjectContext: context,
                    sectionNameKeyPath: "type",
                   cacheName: nil
               )

            try? fetchedResultsController?.performFetch()
                   collectionView.reloadData()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sections = fetchedResultsController?.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.identifier,
                                                              for: indexPath) as! HomeCollectionCell

        guard let item = fetchedResultsController?.object(at: indexPath) else { return UICollectionViewCell() }
        
        // Here IS forse unwrap
        if item.image == nil {
            DispatchQueue.global().async { [weak self] in
                self?.network.fetchData(url: item.imagePath!) { (imgData) -> (Void) in
                    if let imgData = imgData{
                        item.image = imgData
                    }
                }
            }
        }
        
        cell.titleLabel.text = item.type
        
        if let itemImage = item.image{
            cell.img.image = UIImage(data: itemImage)
        }
        
        return cell
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let sections = fetchedResultsController?.sections {
            print("sections.count ", sections.count)
            return sections.count
        }
        return 0
    }
}

// core Data functions extension
extension HomeViewController{
    
    private func updateDatabase(with itemsInfo: [ItemInfo], asType itemType:String){
        container?.performBackgroundTask{ context in
            for itemInfo in itemsInfo {
                try? _ = Item.findOrCreate(itemInfo: itemInfo, itemType:itemType, in: context)
            }
            try? context.save()
        }
    }

    private func updateDatabase(with charactersInfo: [CharacterInfo]){
        container?.performBackgroundTask{ context in
            for characterInfo in charactersInfo {
                try? _ = Character.findOrCreate(characterInfo: characterInfo, in: context)
            }
            try? context.save()
        }
    }
}

// Compositional Layput extension
extension HomeViewController {
    func generateLayoutforSections() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
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

//        let headerSize = NSCollectionLayoutSize(
//          widthDimension: .fractionalWidth(1.0),
//          heightDimension: .estimated(44))
//
//        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
//          layoutSize: headerSize,
//          elementKind: HomeViewController.sectionHeaderElementKind,
//          alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
//        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous
//        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func generateLayout() -> UICollectionViewLayout {
        
        // TODO Create General Layout
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
          layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            
            return self.generateLayoutforSections()
        }
        return layout
    }
}
