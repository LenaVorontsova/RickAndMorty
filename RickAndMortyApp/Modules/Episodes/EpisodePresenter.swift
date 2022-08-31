//
//  EpisodePresenter.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.08.2022.
//

import UIKit
import Alamofire

protocol EpisodePresenting: AnyObject {
    var episodes: [EpisodeInfo] { get set }
    var episodesSearch: [EpisodeInfo] { get set }
    func getInfoEpisodes()
    func searchEpisode(searchText: String)
}

final class EpisodePresenter: EpisodePresenting {
    var episodes: [EpisodeInfo] = []
    var episodesSearch: [EpisodeInfo] = []
    weak var controller: (UIViewController & IViewControllers)?
    let network: NetworkService
    let search: SearchService
    
    init(network: NetworkService, search: SearchService) {
        self.network = network
        self.search = search
    }
    
    func getInfoEpisodes() {
        network.getInfoEpisodes(endPoint: EndPoints.episode.rawValue) { [weak self] result in
            switch result {
            case .success(let serverData):
            guard let self = self else { return }
                self.episodes = serverData.results
                self.episodesSearch = self.episodes
                self.controller?.reloadTable()
            case .failure(let error):
                self?.controller?.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func searchEpisode(searchText: String) {
        episodesSearch = search.search(namable: episodes,
                                       searchText: searchText,
                                       type: EpisodeInfo.self)
        controller?.reloadTable()
    }
}
