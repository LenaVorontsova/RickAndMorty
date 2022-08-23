//
//  NetworkService.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import Foundation
import Alamofire

final class NetworkService {
    var baseURL = ""
    
    static let shared = NetworkService(baseURL: "https://rickandmortyapi.com/api/")
    
    private init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    // get all info about character
    func getInfoCharacters(endPoint: String, completion: @escaping (Result<ServerData, AFError>) -> Void) {
        AF.request(
            self.baseURL + endPoint,
            method: .get)
            .responseDecodable(of: ServerData.self) { response in
                completion(response.result)
            }
    }
    
    func getInfoLocations(endPoint: String, completion: @escaping (Result<ServerDataLocation, AFError>) -> Void) {
        AF.request(
            self.baseURL + endPoint,
            method: .get)
            .responseDecodable(of: ServerDataLocation.self) { response in
                completion(response.result)
            }
    }
    
    func getInfoEpisodes(endPoint: String, completion: @escaping (Result<ServerDataEpisode, AFError>) -> Void) {
        AF.request(
            self.baseURL + endPoint,
            method: .get)
            .responseDecodable(of: ServerDataEpisode.self) { response in
                completion(response.result)
            }
    }
}
