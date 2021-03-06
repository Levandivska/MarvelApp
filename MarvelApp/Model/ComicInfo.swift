//
//  Comic.swift
//  MarvelApp
//
//  Created by оля on 24.02.2021.
//

import Foundation

struct ComicInfo: Codable{
    
    struct Image: Codable{
        var path: String
        var data: Data? = nil
    }
    
    var resourceURL: String
    var title: String
    var description: String
    var image: Image
    
    enum CodingKeys: String, CodingKey{
        case title
        case description
        case image = "thumbnail"
        case resourceURL
    }
}
