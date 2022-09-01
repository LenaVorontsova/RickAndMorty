//
//  SplashScreenPresenter.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 01.09.2022.
//

import UIKit

protocol SplashScreenPresenting: AnyObject {
    var controller: UIViewController? { get set }
    func showTabBar()
}

final class SplashScreenPresenter: SplashScreenPresenting {
    let network: NetworkService
    let search: SearchService
    weak var controller: UIViewController?
    
    init(network: NetworkService, search: SearchService) {
        self.network = network
        self.search = search
    }
    
    func showTabBar() {
        let tabBarVC = TabBarViewController(network: network, search: search)
        tabBarVC.modalPresentationStyle = .fullScreen
        controller?.present(tabBarVC, animated: false)
    }
}
