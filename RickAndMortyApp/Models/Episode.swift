//
//  Episode.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import Foundation
import UIKit

struct ServerDataEpisode: Decodable {
    let results: [EpisodeInfo]?
}

struct EpisodeInfo: Decodable {
    let name: String?
    let air_date: String?
    let episode: String?
}
