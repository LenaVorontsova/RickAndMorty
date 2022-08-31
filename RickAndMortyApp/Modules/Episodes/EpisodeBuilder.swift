//
//  EpisodeBuilder.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.08.2022.
//

import UIKit

enum EpisodeBuilder {
    static func build(network: NetworkService, search: SearchService) -> (UIViewController & IViewControllers) {
        let presenter = EpisodePresenter(network: network, search: search)
        let vc = EpisodesViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
