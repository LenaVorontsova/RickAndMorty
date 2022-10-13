//
//  EpisodeBuilder.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.08.2022.
//

import UIKit

enum EpisodeBuilder {
    static func build(search: SearchService,
                      analytic: AnalyticsServies,
                      dataService: DataService) -> (UIViewController & IViewControllers) {
        let presenter = EpisodePresenter(search: search,
                                         analytic: analytic,
                                         dataService: dataService)
        let vc = EpisodesViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
