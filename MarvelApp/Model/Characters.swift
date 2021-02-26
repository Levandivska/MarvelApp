//
//  Characters.swift
//  MarvelApp
//
//  Created by оля on 26.02.2021.
//

import Foundation

struct Characters: Codable{
    
    struct Results: Codable{
        var results: [Character]
    }
    
    var data: Results
    
}
