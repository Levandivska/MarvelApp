//
//  Character.swift
//  MarvelApp
//
//  Created by оля on 03.03.2021.
//

import UIKit
import CoreData

class Character: NSManagedObject {

    class func create(characterInfo: CharacterInfo, in context: NSManagedObjectContext) -> NSManagedObject{
        let character = Character(context: context)
        character.name = characterInfo.name
        character.id = Int32(characterInfo.id)
        return character
    }
}
