//
//  NetworkService.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import Foundation
import Alamofire

class NetworkService {
    fileprivate var baseURL = ""
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    // get all info about character
    func getInfoCharacters(endPoint: String, completion: @escaping (ServerData) -> Void) {
        AF.request(
            self.baseURL + endPoint,
            method: .get)
            .responseDecodable(of: ServerData.self) { response in
            guard let results = response.value else { return }
            print(results)
            completion(results)
            }
    }
    
    func getInfoLocations(endPoint: String, completion: @escaping (ServerDataLocation) -> Void) {
        AF.request(
            self.baseURL + endPoint,
            method: .get)
            .responseDecodable(of: ServerDataLocation.self) { response in
            guard let results = response.value else { return }
            print(results)
            completion(results)
            }
    }
    
    func getInfoEpisodes(endPoint: String, completion: @escaping (ServerDataEpisode) -> Void) {
        AF.request(
            self.baseURL + endPoint,
            method: .get)
            .responseDecodable(of: ServerDataEpisode.self) { response in
            guard let results = response.value else { return }
            print(results)
            completion(results)
            }
    }
}
