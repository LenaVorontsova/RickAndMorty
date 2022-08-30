//
//  File.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 23.08.2022.
//

import Foundation

protocol Namable {
    var name: String? { get }
}

final class SearchService {
//    static let shared = SearchService()
//    private init() {}
    
    func search<T>(namable: [Namable], searchText: String, type: T.Type) -> [T] where T: Namable {
        var emptyArray: [Namable] = []
        if searchText.isEmpty {
            emptyArray = namable
            return emptyArray as? [T] ?? []
        } else {
            for element in namable {
                if element.name!.lowercased().contains(searchText.lowercased()) {
                    emptyArray.append(element)
                }
            }
        }
        return emptyArray as? [T] ?? []
    }
}
