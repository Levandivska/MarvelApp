//
//  ViewController.swift
//  MarvelApp
//
//  Created by оля on 23.02.2021.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    var network = Networker()
    
    var characters: [NSManagedObject] = []
    var comics: [NSManagedObject] = []
    
    var comicsInfo: [ComicInfo]? = nil
    var charactersInfo: [CharacterInfo] = []
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        network.fetchCharacters { [weak self] (charactersInfo) -> (Void) in
            guard let charactersInfo = charactersInfo else { return }
            self?.charactersInfo = charactersInfo
            self?.fetchCharactersIntoDataBase()
        }
//            characters.forEach{ [weak self] character in
//                self?.network.fetchComics(characterId: character.id){ (comics) -> (Void) in
//                    print("In Main View Controller: ", comics)
//                }
//            }
     //   }

    }

    
    func fetchCharactersIntoDataBase(){
        
        guard let context = AppDelegate.context else { return }
        guard let entity = NSEntityDescription.entity(forEntityName: "Character", in: context) else { return }
        
        charactersInfo.forEach {
            let character = NSManagedObject(entity: entity,
                                         insertInto: context)
            character.setValue($0.name, forKey: "name")
        }
        
        do{
            try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

