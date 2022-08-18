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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        let networkService = NetworkService(baseURL: "https://rickandmortyapi.com/api/")
        networkService.getInfoLocations(endPoint: "location") { result in
            self.locations = result.results!
            self.locationsSearch = self.locations
            self.tableView.reloadData()
        }
        
        self.title = "Locations"
    }
}

extension LocationsViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    // TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsSearch.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "locationsCell",
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
