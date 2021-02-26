//
//  Character.swift
//  MarvelApp
//
//  Created by оля on 25.02.2021.
//

import Foundation

struct Character: Codable{
    struct Image: Codable{
        var path: String
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
