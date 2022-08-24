//
//  NetworkService+extension.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 24.08.2022.
//

import Foundation

extension NetworkService {
    struct Response<T: Decodable>: Decodable {
        let results: T
    }
}
