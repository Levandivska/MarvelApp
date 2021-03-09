//
//  ItemInfo.swift
//  MarvelApp
//
//  Created by оля on 08.03.2021.
//

import Foundation

struct ItemInfo: Codable{
    struct Image: Codable{
        var path: String
        var data: Data? = nil
    }
    
    var title: String
    var id: Int
//    var description: String
    var image: Image
    
    enum CodingKeys: String, CodingKey{
        case title
        case id
//        case description
        case image = "thumbnail"
    }
}
