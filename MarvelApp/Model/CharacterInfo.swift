//
//  Character.swift
//  MarvelApp
//
//  Created by оля on 25.02.2021.
//

import Foundation
import CoreData

class CharacterInfo: Codable {
    
    struct Image: Codable{
        var path: String
        var data: Data? = nil
    }
    
    var id: Int
    var name: String
    var image: Image
    
    enum CodingKeys: String, CodingKey {
        case image = "thumbnail"
        case name
        case id
    }
}

