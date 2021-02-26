//
//  Comics.swift
//  MarvelApp
//
//  Created by оля on 24.02.2021.
//

import Foundation


struct Comics: Codable {
    struct Data: Codable {
        var results : [Comic]
    }
    
    var data:  Data
    
}
