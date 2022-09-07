//
//  Location.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import Foundation
import UIKit

struct LocationInfo: Decodable, Namable {
    var name: String?
    var type: String?
    var dimension: String?
}
