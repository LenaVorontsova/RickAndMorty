//
//  CharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import Alamofire

final class CharacterViewController: UIViewController, IViewControllers {
    private var tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    private var searchBar: UISearchBar = {
        let search = UISearchBar()
        return search
    }()
    private let presenter: CharacterPresenting
    let notifications = NotificationsService()
    
    init(_ presenter: CharacterPresenting) {
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
        presenter.getInfoCharacter()
        self.tableView.register(CharactersTableViewCell.self, forCellReuseIdentifier: CharactersTableViewCell.identifier)
        self.title = R.string.modules.charTitle()
        view.backgroundColor = R.color.backColor()
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

extension CharacterViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.charactersSearch.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.identifier,
                                                       for: indexPath) as? CharactersTableViewCell else {
            return UITableViewCell()
        }
        let cellModel = CharactersTableViewCellFactory.cellModel(presenter.charactersSearch[indexPath.row])
        cell.config(with: cellModel)
        cell.avatarView.image = presenter.charactersSearch[indexPath.row].image
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = presenter.pathCharacterViewModel(indexPath: indexPath)
        let controller = DetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(controller, animated: true)
        let alert = UIAlertController(title: "",
                                      message: "After 5 seconds local notification will appear",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            self.notifications.scheduleNotification(notificationType: "local notification")
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchCharacter(searchText: searchText)
    }
}
