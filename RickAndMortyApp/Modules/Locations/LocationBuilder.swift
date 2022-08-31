//
//  LocationBuilder.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.08.2022.
//

import UIKit

enum LocationBuilder {
    static func build(network: NetworkService, search: SearchService) -> (UIViewController & IViewControllers) {
        let presenter = LocationPresenter(network: network, search: search)
        let vc = LocationsViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
