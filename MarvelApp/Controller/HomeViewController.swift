//
//  ViewController.swift
//  MarvelApp
//
//  Created by оля on 23.02.2021.
//

import UIKit


class HomeViewController: UIViewController {

    var network = Networker()
    
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        network.fetchCharacters { [weak self] (characters) -> (Void) in
//            guard let characters = characters else { return }
//            self?.characters = characters
//
//            characters.forEach{ [weak self] character in
//                self?.network.fetchComics(characterId: character.id){ (comics) -> (Void) in
//                    print("In Main View Controller: ", comics)
//                }
//            }
//        }
        
        // Do any additional setup after loading the view.
    }

}

