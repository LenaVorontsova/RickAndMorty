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
    func pathEpisodeViewModel(indexPath: IndexPath) -> DetailViewModelProtocol
    func loadData()
}

final class EpisodePresenter: EpisodePresenting {
    var episodes: [EpisodeInfo] = []
    var episodesSearch: [EpisodeInfo] = []
    weak var controller: (UIViewController & IViewControllers)?
    let search: SearchService
    let analytic: AnalyticsServies
    let dataService: DataService
    
    init(search: SearchService, analytic: AnalyticsServies, dataService: DataService) {
        self.search = search
        self.analytic = analytic
        self.dataService = dataService
    }
    
    func getInfoEpisodes() {
        self.episodes = self.dataService.fetchEpisodesFromCoreData()
        self.episodesSearch = self.episodes
        self.controller?.reloadTable()
    }
    
    func loadData() {
        dataService.loadData()
    }
    
    func searchEpisode(searchText: String) {
        episodesSearch = search.search(namable: episodes,
                                       searchText: searchText,
                                       type: EpisodeInfo.self)
        controller?.reloadTable()
    }
    
    func pathEpisodeViewModel(indexPath: IndexPath) -> DetailViewModelProtocol {
        return EpisodeViewModel(episode: episodesSearch[indexPath.row], analytic: analytic)
    }
}
