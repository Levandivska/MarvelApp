//
//  Comic.swift
//  MarvelApp
//
//  Created by оля on 03.03.2021.
//

import UIKit
import CoreData

class Comic: NSManagedObject {
    class func create(comicInfo: ComicInfo, in context: NSManagedObjectContext) -> Comic {
        let comic = Comic(context: context)
        comic.title = comicInfo.title
        comic.desc = comicInfo.description
        comic.image = comicInfo.image.data
        return comic
    }
}
