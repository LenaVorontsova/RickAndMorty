//
//  StartService.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 30.08.2022.
//

import UIKit

final class StartService {
    var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
        configureWindow()
    }
    
    func configureWindow() {
        let network = NetworkService()
        let search = SearchService()
        let analytics = GoogleAnalyticsWrapper()
        let notifications = NotificationsService()
        let dataService = DataService()
        let presenter: SplashScreenPresenting = SplashScreenPresenter(
            network: network,
            search: search,
            analytics: analytics,
            notifications: notifications,
            dataService: dataService
        )
        if let win = window {
            win.rootViewController = UINavigationController(
                rootViewController: SplashBuilder.build(
                    network: network,
                    search: search,
                    presenter: presenter,
                    analytics: analytics,
                    notifications: notifications,
                    dataService: dataService
                ))
            win.makeKeyAndVisible()
        }
    }
}
