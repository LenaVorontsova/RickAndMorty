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
        networkService.getInfoEpisodes(endPoint: "episode") { [weak self] result in
            switch result {
            case .success(let serverData):
                guard let self = self else { return }
                if let episode = serverData.results {
                    self.episodes = episode
                } else {
                    self.episodes = []
                }
                self.episodesSearch = self.episodes
                self.tableView.reloadData()
            case .failure(let error):
                print("\(error)")
            }
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
        if let airDateText = episodesSearch[indexPath.row].air_date {
            cell.airDateLabel.text = "Air date: " + airDateText
        } else {
            cell.airDateLabel.text = "Air date: "
        }
                    
        var season = ""
        var episode = ""
        if let range = episodesSearch[indexPath.row].episode?.range(of: "E"),
                let episodeText = episodesSearch[indexPath.row].episode {
            season = String(episodeText[..<range.lowerBound])
            episode = String(episodeText[range.lowerBound...])
        } else {
            season = "number"
            episode = "number"
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
