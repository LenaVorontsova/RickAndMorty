//
//  Location.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import Foundation
import UIKit

struct ServerDataLocation: Decodable {
    let results: [LocationInfo]?
}

struct LocationInfo: Decodable {
    let name: String?
    let type: String?
    let dimension: String?
}
