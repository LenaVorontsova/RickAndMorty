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
        
        let presenter: SplashScreenPresenting = SplashScreenPresenter(
            network: network,
            search: search,
            coreData: coreData
        )
        if let win = window {
            win.rootViewController = UINavigationController(
                rootViewController: SplashBuilder.build(
                    network: network,
                    search: search,
                    presenter: presenter,
                    coreData: coreData)) 
            win.makeKeyAndVisible()
        }
    }
}
