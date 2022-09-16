//
//  EpisodesViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import Alamofire
import SnapKit

final class EpisodesViewController: UIViewController, IViewControllers {
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
        fatalError(R.string.modules.fatalError())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        configureConstraints()
        
        presenter.getInfoEpisodes()
        
        self.tableView.register(EpisodesTableViewCell.self, forCellReuseIdentifier: EpisodesTableViewCell.identifier)
        
        self.title = R.string.modules.episodeTitle()
        view.backgroundColor = UIColor(red: 200 / 255, green: 246 / 255, blue: 236 / 255, alpha: 1)
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
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.trailing.leading.equalToSuperview()
        }
    }
}

extension EpisodesViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.episodesSearch.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodesTableViewCell.identifier,
                                                       for: indexPath) as? EpisodesTableViewCell else {
            return UITableViewCell()
        }

        let cellModel = EpisodesTableViewCellFactory.cellModel(presenter.episodesSearch[indexPath.row])
        cell.config(with: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openDetails(indexPath: indexPath)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchEpisode(searchText: searchText)
    }
}
