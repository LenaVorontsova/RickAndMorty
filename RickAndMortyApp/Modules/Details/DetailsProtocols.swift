//
//  DetailsInput.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 16.09.2022.
//

import Foundation
import UIKit

protocol DetailViewModelProtocol {
    var image: UIImage? { get }
    var titleLabel: [String]? { get }
}
