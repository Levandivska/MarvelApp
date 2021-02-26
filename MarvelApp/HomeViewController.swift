//
//  ViewController.swift
//  MarvelApp
//
//  Created by оля on 23.02.2021.
//

import UIKit

class HomeViewController: UIViewController {

    var network = Networker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network.fetchCharacters()
        // Do any additional setup after loading the view.
    }


}

