//
//  SplashBuilder.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 01.09.2022.
//

import UIKit

enum SplashBuilder {
    static func build(network: NetworkService,
                      search: SearchService,
                      presenter: SplashScreenPresenting,
                      analytics: AnalyticsServies,
                      notifications: INotificationService,
                      dataService: IDataService
    ) -> UIViewController {
        let presenter: SplashScreenPresenting = SplashScreenPresenter(network: network,
                                                                      search: search,
                                                                      analytics: analytics,
                                                                      notifications: notifications,
                                                                      dataService: dataService)
        let vc = SplashViewController(search: search, presenter: presenter)
        presenter.controller = vc
        return vc
    }
}
