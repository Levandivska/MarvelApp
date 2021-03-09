//
//  Item.swift
//  MarvelApp
//
//  Created by оля on 08.03.2021.
//

import UIKit
import CoreData

class Item: NSManagedObject {
    class func findOrCreate(itemInfo: ItemInfo, itemType:String, in context: NSManagedObjectContext) throws -> Item? {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", NSNumber(value: itemInfo.id) )
        do {
            let matches = try context.fetch(request)
            if matches.count > 0{
                assert(matches.count == 1, "Item.findOrCreate DataBase inconsistency" )
                return matches[0]
            }

        }catch {
            throw error
        }
        
        let item = Item(context: context)
        item.title = itemInfo.title
//        item.desc = itemInfo.description
        item.imagePath = itemInfo.image.path
        item.type = itemType
        item.id = Int32(itemInfo.id)
        item.image = nil
        return item
    }
}
