//
//  LocationBuilder.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.08.2022.
//

import UIKit

enum LocationBuilder {
    static func build(search: SearchService,
                      analytic: AnalyticsServies,
                      dataService: IDataService) -> (UIViewController & IViewControllers) {
        let presenter = LocationPresenter(search: search,
                                          analytic: analytic,
                                          dataService: dataService)
        let vc = LocationsViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
