//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import Foundation
import UIKit

struct Character: Decodable, Namable {
    let name: String?
    let gender: String?
    let species: String?
    let location: Location?
    let image: String?
}

struct Location: Decodable {
    let name: String?
    let url: String?
}
