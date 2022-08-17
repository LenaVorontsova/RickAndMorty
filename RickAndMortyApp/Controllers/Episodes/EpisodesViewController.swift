//
//  EpisodesViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import Alamofire

class EpisodesViewController: UIViewController {
    fileprivate var episodes: [EpisodeInfo] = []
    fileprivate var episodesSearch: [EpisodeInfo] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        let networkService = NetworkService(baseURL: "https://rickandmortyapi.com/api/")
        networkService.getInfoEpisodes(endPoint: "episode") { result in
            self.episodes = result.results!
            self.episodesSearch = self.episodes
            self.tableView.reloadData()
        }
        
        self.title = "Episodes"
    }
}

extension EpisodesViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    // TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodesSearch.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "episodesCell",
                                                       for: indexPath) as? EpisodesTableViewCell else {
            return UITableViewCell()
        }

        cell.nameLabel.text = episodesSearch[indexPath.row].name
        cell.airDateLabel.text = "Air date: " + episodesSearch[indexPath.row].air_date!
                    
        var season = ""
        var episode = ""
        if let range = episodesSearch[indexPath.row].episode?.range(of: "E") {
            season = String(episodesSearch[indexPath.row].episode![..<range.lowerBound])
            episode = String(episodesSearch[indexPath.row].episode![range.lowerBound...])
        }
        cell.seasonLabel.text = "Season: " + season
        cell.episodeLabel.text = "Episode: " + episode
                    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    // SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        episodesSearch = []
        
        if searchText.isEmpty {
            episodesSearch = episodes
        } else {
            for episode in episodes {
                if episode.name!.lowercased().contains(searchText.lowercased()) {
                    episodesSearch.append(episode)
                }
            }
        }
        self.tableView.reloadData()
    }
}
