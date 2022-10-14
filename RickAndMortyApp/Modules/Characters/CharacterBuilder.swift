//
//  CharacterBuilder.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.08.2022.
//

import UIKit

enum CharacterBuilder {
    static func build(search: SearchService,
                      analytic: AnalyticsServies,
                      notifications: INotificationService,
                      dataService: IDataService) -> (UIViewController & IViewControllers) {
        let presenter = CharacterPresenter(search: search,
                                           analytic: analytic,
                                           notifications: notifications,
                                           dataService: dataService)
        let vc = CharacterViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
