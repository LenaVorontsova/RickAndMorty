//
//  CharacterBuilder.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.08.2022.
//

import UIKit

enum CharacterBuilder {
    static func build(network: NetworkService, search: SearchService) -> (UIViewController & IViewControllers) {
        let presenter = CharacterPresenter(with: network, search: search)
        let vc = CharacterViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
