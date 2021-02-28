//
//  Characters.swift
//  MarvelApp
//
//  Created by оля on 26.02.2021.
//

import Foundation

struct CharactersInfo: Codable{
    
    struct Results: Codable{
        var results: [CharacterInfo]
    }
    
    var data: Results
    
}
