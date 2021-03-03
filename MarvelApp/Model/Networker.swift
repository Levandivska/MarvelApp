//
//  Networker.swift
//  MarvelApp
//
//  Created by оля on 23.02.2021.
//

//import Foundation
import Alamofire

class Networker {
       
    private let mainURL = "https://gateway.marvel.com/v1/public/"
    private let apiKey = "70d082f0538ecdf0444ff3bed463b36a"
    private let ts = "1"
    private let hash = "204f771d43008acf58db76f652f89db1"
    private var parameters : [String: String]? = nil
        
    init(){
        self.parameters = ["apikey" : self.apiKey, "ts": self.ts, "hash" : self.hash]
    }
    
    func fetchCharacters(completion: @escaping ([CharacterInfo]?) -> (Void)){
        guard let parameters = parameters else { return }
        
        AF.request(mainURL + "characters", parameters: parameters)
            .validate()
            .responseDecodable(of: CharactersInfo.self){ response in
                DispatchQueue.main.async {
                    completion(response.value?.data.results)
                }
            }
    }
    
    func fetchComics(characterId: Int, completion : @escaping ([ComicInfo]?) -> (Void)) {
        guard let parameters = parameters else { return }
        AF.request(mainURL + "characters/" + String(characterId) + "/comics", parameters: parameters)
            .validate()
            .responseDecodable(of: ComicsInfo.self){ response in
                DispatchQueue.main.async{
                    completion(response.value?.data.results)
                }
                
        }
    }
    
    func fetchData(url: String, completion: @escaping (Data?) -> (Void) ) {
        AF.request(url+"/portrait_xlarge.jpg" , parameters: parameters)
            .validate()
            .responseData{ response in

                DispatchQueue.main.async{
                    completion(response.value)
                }
                
            }
    }
}


