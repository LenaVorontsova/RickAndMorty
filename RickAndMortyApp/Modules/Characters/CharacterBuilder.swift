//
//  CharacterBuilder.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.08.2022.
//

import UIKit

enum CharacterBuilder {
    static func build(coreData: CoreDataService,
                      search: SearchService,
                      analytic: AnalyticsServies) -> (UIViewController & IViewControllers) {
        let presenter = CharacterPresenter(with: coreData, search: search, analytic: analytic)
        let vc = CharacterViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
