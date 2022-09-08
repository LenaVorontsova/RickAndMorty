//
//  NetworkService.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import Foundation
import Alamofire
import Rswift

final class NetworkService {
    var baseURL = R.string.services.baseUrl()
    
    func getInfoCharacters(endPoint: String, completion: @escaping (Result<Response<[Character]>, AFError>) -> Void) {
        AF.request(
            self.baseURL + endPoint,
            method: .get)
            .responseDecodable(of: Response<[Character]>.self) { response in
                completion(response.result)
            }
    }
    
    func getInfoLocations(endPoint: String, completion: @escaping (Result<Response<[LocationInfo]>, AFError>) -> Void) {
        AF.request(
            self.baseURL + endPoint,
            method: .get)
            .responseDecodable(of: Response<[LocationInfo]>.self) { response in
                completion(response.result)
            }
    }

    func getInfoEpisodes(endPoint: String, completion: @escaping (Result<Response<[EpisodeInfo]>, AFError>) -> Void) {
        AF.request(
            self.baseURL + endPoint,
            method: .get)
            .responseDecodable(of: Response<[EpisodeInfo]>.self) { response in
                completion(response.result)
            }
    }
}
