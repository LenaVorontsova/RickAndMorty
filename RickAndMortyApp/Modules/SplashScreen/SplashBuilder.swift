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
                      coreData: CoreDataService,
                      analytics: AnalyticsServies,
                      notifications: INotificationService,
                      dataService: DataService
    ) -> UIViewController {
        let presenter: SplashScreenPresenting = SplashScreenPresenter(network: network,
                                                                      search: search,
                                                                      coreData: coreData,
                                                                      analytics: analytics,
                                                                      notifications: notifications,
                                                                      dataService: dataService)
        let vc = SplashViewController(search: search, presenter: presenter)
        presenter.controller = vc
        return vc
    }
}
