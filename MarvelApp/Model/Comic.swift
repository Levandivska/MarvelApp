//
//  Comic.swift
//  MarvelApp
//
//  Created by оля on 24.02.2021.
//

import Foundation

struct Comic: Codable{
    var title: String
    var description: String
    var image: String
    
    enum CodingKeys: String, CodingKey{
        case title
        case description
        case image = "thumbnail"
    }
}
