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
    func openDetails(indexPath: IndexPath)
}

final class EpisodePresenter: EpisodePresenting {
    var episodes: [EpisodeInfo] = []
    var episodesSearch: [EpisodeInfo] = []
    weak var controller: (UIViewController & IViewControllers)?
    let coreData: CoreDataService
    let search: SearchService
    
    init(coreData: CoreDataService, search: SearchService) {
        self.coreData = coreData
        self.search = search
    }
    
    func getInfoEpisodes() {
        self.episodes = self.coreData.fetchEpisodesFromCoreData()
        self.episodesSearch = self.episodes
        self.controller?.reloadTable()
    }
    
    func searchEpisode(searchText: String) {
        episodesSearch = search.search(namable: episodes,
                                       searchText: searchText,
                                       type: EpisodeInfo.self)
        controller?.reloadTable()
    }
    
    func openDetails(indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        controller?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
