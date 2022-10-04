//
//  LocationBuilder.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.08.2022.
//

import UIKit

enum LocationBuilder {
    static func build(coreData: CoreDataService,
                      search: SearchService,
                      analytic: AnalyticsServies) -> (UIViewController & IViewControllers) {
        let presenter = LocationPresenter(coreData: coreData, search: search, analytic: analytic)
        let vc = LocationsViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
