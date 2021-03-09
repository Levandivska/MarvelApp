//
//  FavoritesViewController.swift
//  MarvelApp
//
//  Created by оля on 27.02.2021.
//

import UIKit
import Foundation

class FavoritesViewController: UIViewController {

//    @IBOutlet weak var tableView: UITableView!

    var network = Networker()
    
    var favoritesComics: [ComicInfo] = []
    var characters: [CharacterInfo] = []

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 80
//
//        // fetch Characters List
//        network.fetchCharacters { [weak self] (characters) -> (Void) in
//            guard let characters = characters else { return }
//            self?.characters = characters
//
//            // For each character fetch list of comics
//            characters.forEach { [weak self] character in
//                self?.network.fetchComics(characterId: character.id){ (comics) -> (Void) in
//                    self?.favoritesComics += comics ?? []
//                    self?.tableView.reloadData()
//                }
//            }
//        }
//    }
//}
//
//extension FavoritesViewController: UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return favoritesComics.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as? FavoriteCell else {
//            print("errror")
//            return tableView.dequeueReusableCell(withIdentifier: "FavoriteCell")!
//        }
//
//        var comic = favoritesComics[indexPath.row]
//
//        cell.titleLabel.text = comic.title
//        cell.descriptionLabel.text = comic.description
//
//
//        if comic.image.data == nil {
//            // fetch image data from internete
//            DispatchQueue.global().async { [weak self] in
//                self?.network.fetchData(url: comic.image.path) { (imgData) -> (Void) in
//                    if let imgData = imgData {
//
//                        // set comic.image.data property
//                        comic.image.data = imgData
//                        self?.favoritesComics[indexPath.row] = comic
//                    }
//                }
//            }
//        }
//
//        if let imgData = comic.image.data {
//            cell.mainImage.image = UIImage(data: imgData)
//        }
//
//        return cell
//    }
}
