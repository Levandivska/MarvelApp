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

    var network = Networker()
    
    var characters: [Character] = []
    var comics: [Comic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        // fetch Character list from network
        network.fetchCharacters { [weak self] (charactersInfo) -> (Void) in
            guard let charactersInfo = charactersInfo else { return }
            self?.charactersInfo = charactersInfo
            self?.updateDatabase(with: charactersInfo)
        }
        
            //  for each character fetch comics
            charactersInfo.forEach{ [weak self] character in
                self?.network.fetchComics(characterId: character.id){ (comics) -> (Void) in
                    if let comics = comics {
                        self?.updateDatabase(with: comics)
                    }
                }
            }
    }
    
    // fetch events
    // insert events
    
    // fetch stories
    // insert stories
    
    // fetch series
    // fetch events
}


// core Data functions extension
extension HomeViewController {
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
        container?.performBackgroundTask{ context in
            for comicInfo in comicsInfo {
                _ = Comic.create(comicInfo: comicInfo, in: context)
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
