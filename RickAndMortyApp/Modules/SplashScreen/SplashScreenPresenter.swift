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
    let coreData: CoreDataService
    let analytics: AnalyticsServies
    let notifications: INotificationService
    let dataService: DataService
    weak var controller: UIViewController?
    
    init(network: NetworkService,
         search: SearchService,
         coreData: CoreDataService,
         analytics: AnalyticsServies,
         notifications: INotificationService,
         dataService: DataService) {
        self.network = network
        self.search = search
        self.coreData = coreData
        self.analytics = analytics
        self.notifications = notifications
        self.dataService = dataService
    }

    func getInfo() {
        dataService.loadData()
        self.showTabBar()
    }
    
    func showTabBar() {
        let debugMenu = DebugMenuViewController(dataService: coreData)
        let tabBarVC = TabBarViewController(search: search,
                                            coreData: coreData,
                                            analytic: analytics,
                                            notifications: notifications,
                                            debugMenu: debugMenu,
                                            dataService: dataService)
        tabBarVC.modalPresentationStyle = .fullScreen
        controller?.present(tabBarVC, animated: false)
    }
}
