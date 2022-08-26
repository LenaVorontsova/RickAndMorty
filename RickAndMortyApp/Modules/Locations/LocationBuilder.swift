//
//  LocationBuilder.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.08.2022.
//

import UIKit

enum LocationBuilder {
    static func build() -> (UIViewController & ILocationsViewController) {
        let presenter = LocationPresenter()
        let vc = LocationsViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
