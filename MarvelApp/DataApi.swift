//
//  DataApi.swift
//  MarvelApp
//
//  Created by оля on 24.02.2021.
//

import Foundation

struct DataApi {
    static let mainURL = "https://gateway.marvel.com/v1/public/comics"
    static let apiKey = "70d082f0538ecdf0444ff3bed463b36a"
    static let ts = 1
    static let hash = "204f771d43008acf58db76f652f89db1"
    
    static func getAllHeroesURL() -> String {
        "\(self.mainURL)?ts=\(self.ts)&apikey=\(self.apiKey)&hash=\(self.hash)"
    }
}
