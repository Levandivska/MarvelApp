//
//  DataHomeViewController.swift
//  MarvelApp
//
//  Created by оля on 03.03.2021.
//


import UIKit
import CoreData

class DataHomeViewController: HomeViewController {
            
    private func updateDatabase(comicsInfo: [ComicInfo]){
        container?.performBackgroundTask{ context in
            for comicInfo in comicsInfo {
                _ = Comic.create(comicInfo: comicInfo, in: context)
            }
            try? context.save()
        }
    }
    

}
