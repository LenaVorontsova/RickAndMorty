//
//  Episode.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import Foundation
import UIKit

struct EpisodeInfo: Decodable, Namable {
    var name: String?
    var air_date: String?
    var episode: String?
}
