//
//  Data.swift
//  MarvelApp
//
//  Created by оля on 25.02.2021.
//

import Foundation

struct Data: Codable{
    
    struct Results: Codable{
        var results: [Character]
    }
    
    var data: Results
    
}
