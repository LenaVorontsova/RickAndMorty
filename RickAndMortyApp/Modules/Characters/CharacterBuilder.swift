//
//  CharacterBuilder.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.08.2022.
//

import UIKit

enum CharacterBuilder {
    static func build() -> (UIViewController & IViewControllers) {
        let presenter = CharacterPresenter()
        let vc = CharacterViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
