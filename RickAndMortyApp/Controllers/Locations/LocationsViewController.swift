//
//  LocationsViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import Alamofire

class LocationsViewController: UIViewController {
    fileprivate var locations: [LocationInfo] = []
    fileprivate var locationsSearch: [LocationInfo] = []
    
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
        
        self.tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.identifier)
        
        let networkService = NetworkService(baseURL: "https://rickandmortyapi.com/api/")
        networkService.getInfoLocations(endPoint: "location") { [weak self] result in
            switch result {
            case .success(let serverData):
                guard let self = self else { return }
                if let location = serverData.results {
                    self.locations = location
                } else {
                    self.locations = []
                }
                self.locationsSearch = self.locations
                self.tableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self?.present(alert, animated: true)
            }
        }
        
        self.title = "Locations"
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

extension LocationsViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    // TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsSearch.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier,
                                                       for: indexPath) as? LocationTableViewCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = locationsSearch[indexPath.row].name
        
        if let typeText = locationsSearch[indexPath.row].type,
           let dimensionText = locationsSearch[indexPath.row].dimension {
            cell.typeLabel.text = "Type: " + typeText
            cell.dimensionLabel.text = "Dimension: " + dimensionText
        }
                    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        locationsSearch = []
        
        if searchText.isEmpty {
            locationsSearch = locations
        } else {
            for location in locations {
                if location.name!.lowercased().contains(searchText.lowercased()) {
                    locationsSearch.append(location)
                }
            }
        }
        self.tableView.reloadData()
    }
}
