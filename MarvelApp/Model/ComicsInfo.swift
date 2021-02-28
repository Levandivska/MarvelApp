//
//  Comics.swift
//  MarvelApp
//
//  Created by оля on 24.02.2021.
//

import Foundation

struct ComicsInfo: Codable {
    
    struct Results: Codable {
        var results : [ComicInfo]
    }
    
    var data: Results
}
