//
//  EpisodeBuilder.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.08.2022.
//

import UIKit

enum EpisodeBuilder {
    static func build() -> (UIViewController & IViewControllers) {
        let presenter = EpisodePresenter()
        let vc = EpisodesViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
