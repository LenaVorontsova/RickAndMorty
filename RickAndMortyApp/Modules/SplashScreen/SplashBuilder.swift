//
//  SplashBuilder.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 01.09.2022.
//

import UIKit

enum SplashBuilder {
    static func build(network: NetworkService, search: SearchService, presenter: SplashScreenPresenting, coreData: CoreDataService) -> UIViewController {
        let presenter: SplashScreenPresenting = SplashScreenPresenter(network: network, search: search, coreData: coreData)
        let vc = SplashViewController(with: network, search: search, presenter: presenter)
        presenter.controller = vc
        return vc
    }
}
