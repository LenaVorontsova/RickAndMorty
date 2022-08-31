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
        if let win = window {
            win.rootViewController = UINavigationController(rootViewController: MainViewController(with: network,
                                                                                            search: search))
            win.makeKeyAndVisible()
        }
    }
}
