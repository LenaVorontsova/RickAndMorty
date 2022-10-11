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
    var prodURL = R.string.services.baseUrl()
    var testURL = "https://breakingbadapi.com/api/quotes"
    
    private func checkSwitch() -> String {
        var baseURL = ""
        if UserDefaults.standard.bool(forKey: "SwitchOn") {
            baseURL = self.prodURL
        } else {
            baseURL = self.testURL
        }
        return baseURL
    }
    
    func getInfoCharacters(endPoint: String, completion: @escaping (Result<Response<[CharacterNetwork]>, AFError>) -> Void) {
        let baseURL = checkSwitch()
        AF.request(
            baseURL + endPoint,
            method: .get)
            .responseDecodable(of: Response<[CharacterNetwork]>.self) { response in
                completion(response.result)
            }
    }
    
    func getInfoLocations(endPoint: String, completion: @escaping (Result<Response<[LocationInfo]>, AFError>) -> Void) {
        let baseURL = checkSwitch()
        AF.request(
            baseURL + endPoint,
            method: .get)
            .responseDecodable(of: Response<[LocationInfo]>.self) { response in
                completion(response.result)
            }
    }

    func getInfoEpisodes(endPoint: String, completion: @escaping (Result<Response<[EpisodeInfo]>, AFError>) -> Void) {
        let baseURL = checkSwitch()
        AF.request(
            baseURL + endPoint,
            method: .get)
            .responseDecodable(of: Response<[EpisodeInfo]>.self) { response in
                completion(response.result)
            }
    }
}
