//
//  LocationsViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import Alamofire
import SnapKit

protocol ILocationsViewController: AnyObject {
    func showAlert(message: String)
    func reloadTable()
}

final class LocationsViewController: UIViewController, ILocationsViewController {
    private var tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    private var searchBar: UISearchBar = {
        let search = UISearchBar()
        return search
    }()
    
    private let presenter: LocationPresenting
    
    init(_ presenter: LocationPresenting) {
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
        
        presenter.getInfoLocation()
        
        self.tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.identifier)
        
        self.title = "Locations"
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

extension LocationsViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    // TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.locationsSearch.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier,
                                                       for: indexPath) as? LocationTableViewCell else {
            return UITableViewCell()
        }
        
        let cellModel = LocationTableViewCellFactory.cellModel(presenter.locationsSearch[indexPath.row])
        cell.config(with: cellModel)
                    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.locationsSearch = SearchService.shared.search(namable: presenter.locations, searchText: searchText, type: LocationInfo.self)
        self.tableView.reloadData()
    }
}
