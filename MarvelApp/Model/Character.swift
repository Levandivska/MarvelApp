//
//  Character.swift
//  MarvelApp
//
//  Created by оля on 03.03.2021.
//

import UIKit
import CoreData

class Character: NSManagedObject {

    class func findOrCreate(characterInfo: CharacterInfo, in context: NSManagedObjectContext) throws -> NSManagedObject?{
        
        let request: NSFetchRequest<Character> = Character.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", NSNumber(value: characterInfo.id) )
        do {
            let matches = try context.fetch(request)
            if matches.count > 0{
                assert(matches.count == 1, "Character.createOrFind -- inconsistency")
                return matches[0]
            }
        } catch{
            throw error
        }
        
        let character = Character(context: context)
        character.name = characterInfo.name
        character.id = Int32(characterInfo.id)
        print("created \(characterInfo.name)")
        return character
    }
}
