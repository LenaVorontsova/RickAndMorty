//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import Foundation
import UIKit

struct CharacterNetwork: Decodable, Namable {
    var name: String?
    var gender: String?
    var species: String?
    var location: Location?
    var image: String?
}

struct Location: Decodable {
    var name: String?
    var url: String?
}

struct Character: Decodable, Namable {
    var name: String?
    var gender: String?
    var species: String?
    var location: Location?
    var image: UIImage?
}
