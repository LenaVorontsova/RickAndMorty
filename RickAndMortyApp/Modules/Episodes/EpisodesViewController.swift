//
//  EpisodesViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import Alamofire
import SnapKit

protocol IEpisodesViewController: AnyObject {
    var episodes: [EpisodeInfo] { get set }
    var episodesSearch: [EpisodeInfo] { get set }
    func showAlert(message: String)
    func reloadTable()
}

final class EpisodesViewController: UIViewController, IEpisodesViewController {
    var episodes: [EpisodeInfo] = []
    var episodesSearch: [EpisodeInfo] = []
    
    private var tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    private var searchBar: UISearchBar = {
        let search = UISearchBar()
        return search
    }()
    
    private let presenter: EpisodePresenting
    
    init(_ presenter: EpisodePresenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        configureConstraints()
        
        presenter.getInfoEpisodes()
        
        self.tableView.register(EpisodesTableViewCell.self, forCellReuseIdentifier: EpisodesTableViewCell.identifier)
        
        self.title = "Episodes"
        view.backgroundColor = UIColor(red: 200 / 255, green: 246 / 255, blue: 236 / 255, alpha: 1)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: "\(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func reloadTable() {
        self.tableView.reloadData()
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
        return presenter.episodesSearch.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodesTableViewCell.identifier,
                                                       for: indexPath) as? EpisodesTableViewCell else {
            return UITableViewCell()
        }

        cell.nameLabel.text = presenter.episodesSearch[indexPath.row].name
        if let airDateText = presenter.episodesSearch[indexPath.row].air_date {
            cell.airDateLabel.text = "Air date: " + airDateText
        } else {
            cell.airDateLabel.text = "Air date: "
        }
                    
        var season = ""
        var episode = ""
        if let range = presenter.episodesSearch[indexPath.row].episode?.range(of: "E"),
           let episodeText = presenter.episodesSearch[indexPath.row].episode {
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
