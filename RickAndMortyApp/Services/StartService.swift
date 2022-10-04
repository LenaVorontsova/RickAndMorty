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
        let coreData = CoreDataService()
        let analytics = GoogleAnalyticsWrapper()
        let notifications = NotificationsService()
        let presenter: SplashScreenPresenting = SplashScreenPresenter(
            network: network,
            search: search,
            coreData: coreData,
            analytics: analytics,
            notifications: notifications
        )
        if let win = window {
            win.rootViewController = UINavigationController(
                rootViewController: SplashBuilder.build(
                    network: network,
                    search: search,
                    presenter: presenter,
                    coreData: coreData,
                    analytics: analytics,
                    notifications: notifications
                ))
            win.makeKeyAndVisible()
        }
    }
}
