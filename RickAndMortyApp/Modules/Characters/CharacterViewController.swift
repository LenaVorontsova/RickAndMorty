//
//  CharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import Alamofire

protocol ICharacterViewController: AnyObject {
//    var characters: [Character] { get set }
//    var charactersSearch: [Character] { get set }
    func showAlert(message: String)
    func reloadTable()
}

final class CharacterViewController: UIViewController, ICharacterViewController {
//    var characters: [Character] = []
//    var charactersSearch: [Character] = []
    
    private var tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    private var searchBar: UISearchBar = {
        let search = UISearchBar()
        return search
    }()
    
    private let presenter: CharacterPresenting
    
    init(_ presenter: CharacterPresenting) {
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
        
        presenter.getInfoCharacter()
        
        self.tableView.register(CharactersTableViewCell.self, forCellReuseIdentifier: CharactersTableViewCell.identifier)
        
        self.title = "Characters"
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

extension CharacterViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    // TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.charactersSearch.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.identifier,
                                                       for: indexPath) as? CharactersTableViewCell else {
            return UITableViewCell()
        }

        if let urlString = presenter.charactersSearch[indexPath.row].image,
                   let url = URL(string: urlString),
                   let data = try? Data(contentsOf: url) {
                    cell.avatarView.image = UIImage(data: data)
                } else {
                    cell.avatarView.image = UIImage(systemName: "person.circle.fill")
                }
            
        let cellModel = CharactersTableViewCellFactory.cellModel(presenter.charactersSearch[indexPath.row])
        cell.config(with: cellModel)
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    // SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchCharacter(searchText: searchText)
    }
}
