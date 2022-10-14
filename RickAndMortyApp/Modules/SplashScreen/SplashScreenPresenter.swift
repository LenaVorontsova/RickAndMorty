//
//  SplashScreenPresenter.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 01.09.2022.
//

import UIKit
import Alamofire

protocol SplashScreenPresenting: AnyObject {
    var controller: UIViewController? { get set }
    func showTabBar()
    func getInfo()
}

final class SplashScreenPresenter: SplashScreenPresenting {
    let network: NetworkService
    let search: SearchService
    let analytics: AnalyticsServies
    let notifications: INotificationService
    let dataService: IDataService
    weak var controller: UIViewController?
    
    init(network: NetworkService,
         search: SearchService,
         analytics: AnalyticsServies,
         notifications: INotificationService,
         dataService: IDataService) {
        self.network = network
        self.search = search
        self.analytics = analytics
        self.notifications = notifications
        self.dataService = dataService
    }

    func getInfo() {
        dataService.loadData()
        self.showTabBar()
    }
    
    func showTabBar() {
        let debugMenu = DebugMenuViewController(dataService: dataService)
        let tabBarVC = TabBarViewController(search: search,
                                            analytic: analytics,
                                            notifications: notifications,
                                            debugMenu: debugMenu,
                                            dataService: dataService)
        tabBarVC.modalPresentationStyle = .fullScreen
        controller?.present(tabBarVC, animated: false)
    }
}
