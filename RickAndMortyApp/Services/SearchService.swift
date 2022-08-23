//
//  File.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 23.08.2022.
//

import Foundation

final class SearchService {
    static let shared = SearchService()
    private init() {}
    
    func searchEpisode(fullArray: [EpisodeInfo], searchText: String) -> [EpisodeInfo] {
        var emptyArray: [EpisodeInfo] = []
        if searchText.isEmpty {
            emptyArray = fullArray
            return emptyArray
        } else {
            for element in fullArray {
                if element.name!.lowercased().contains(searchText.lowercased()) {
                    emptyArray.append(element)
                }
            }
        }
        return emptyArray
    }
    
    func searchLocation(fullArray: [LocationInfo], searchText: String) -> [LocationInfo] {
        var emptyArray: [LocationInfo] = []
        if searchText.isEmpty {
            emptyArray = fullArray
            return emptyArray
        } else {
            for element in fullArray {
                if element.name!.lowercased().contains(searchText.lowercased()) {
                    emptyArray.append(element)
                }
            }
        }
        return emptyArray
    }
    
    func searchCharacter(fullArray: [Character], searchText: String) -> [Character] {
        var emptyArray: [Character] = []
        if searchText.isEmpty {
            emptyArray = fullArray
            return emptyArray
        } else {
            for element in fullArray {
                if element.name!.lowercased().contains(searchText.lowercased()) {
                    emptyArray.append(element)
                }
            }
        }
        return emptyArray
    }
}
