//
//  ItemsInfo.swift
//  MarvelApp
//
//  Created by оля on 08.03.2021.
//

import Foundation

struct ItemsInfo: Codable {
    
    struct Results: Codable {
        var results : [ItemInfo]
    }
    
    var data: Results
}
