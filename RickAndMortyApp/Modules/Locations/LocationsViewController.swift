//
//  LocationsViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import Alamofire
import SnapKit

final class LocationsViewController: UIViewController, IViewControllers {
    private var tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    private var searchBar: UISearchBar = {
        let search = UISearchBar()
        return search
    }()
    private var refreshControl: UIRefreshControl!
    private let presenter: LocationPresenting
    
    init(_ presenter: LocationPresenting) {
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
        presenter.getInfoLocation()
        self.tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.identifier)
        self.title = R.string.modules.locTitle()
        view.backgroundColor = R.color.backColor()
        configureRefresh()
    }
    
    private func configureRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc
    func refreshData() {
        presenter.loadData()
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
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

extension LocationsViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = presenter.pathLocationViewModel(indexPath: indexPath)
        let controller = DetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchLocation(searchText: searchText)
    }
}
