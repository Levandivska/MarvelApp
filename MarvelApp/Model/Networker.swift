//
//  Networker.swift
//  MarvelApp
//
//  Created by оля on 23.02.2021.
//

//import Foundation
import Alamofire

class Networker {
       
    private let mainURL = "https://gateway.marvel.com/v1/public/characters"
    private let apiKey = "70d082f0538ecdf0444ff3bed463b36a"
    private let ts = 1
    private let hash = "204f771d43008acf58db76f652f89db1"
    
    func fetchCharacters(){
        AF.request(mainURL, parameters: ["apikey" : apiKey, "ts": ts, "hash" : hash])
            .validate()
            .responseDecodable(of: Data.self){ responce in
                print(responce)
            }
    }
}


