//
//  EpisodesViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import Alamofire
import SnapKit

final class EpisodesViewController: UIViewController {
    fileprivate var episodes: [EpisodeInfo] = []
    fileprivate var episodesSearch: [EpisodeInfo] = []
    
    private var tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    private var searchBar: UISearchBar = {
        let search = UISearchBar()
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        configureConstraints()
        
        self.tableView.register(EpisodesTableViewCell.self, forCellReuseIdentifier: EpisodesTableViewCell.identifier)
        
        NetworkService.shared.getInfoEpisodes(endPoint: EndPoints.episode.rawValue) { [weak self] result in
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
                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self?.present(alert, animated: true)
            }
        }
        
        self.title = "Episodes"
        view.backgroundColor = UIColor(red: 200 / 255, green: 246 / 255, blue: 236 / 255, alpha: 1)
    }
    
    private func configureConstraints() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.leading.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalToSuperview()
            make.trailing.leading.equalToSuperview()
        }
    }
}

extension EpisodesViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    // TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodesSearch.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodesTableViewCell.identifier,
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
        episodesSearch = SearchService.shared.search(namable: episodes, searchText: searchText, type: EpisodeInfo.self)
        self.tableView.reloadData()
    }
}
