//
//  CharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import Alamofire

class CharacterViewController: UIViewController {
    fileprivate var characters: [Character] = []
    fileprivate var charactersSearch: [Character] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        let networkService = NetworkService(baseURL: "https://rickandmortyapi.com/api/")
        networkService.getInfoCharacters(endPoint: "character") { [weak self] result in
            switch result {
            case .success(let serverData):
                guard let self = self else { return }
                if let character = serverData.results {
                    self.characters = character
                } else {
                    self.characters = []
                }
                self.charactersSearch = self.characters
                self.tableView.reloadData()
            case .failure(let error):
                print("\(error)")
            }
        }
        
        self.title = "Characters"
    }
}

extension CharacterViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    // TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersSearch.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell",
                                                       for: indexPath) as? CharactersTableViewCell else {
            return UITableViewCell()
        }

        if let urlString = charactersSearch[indexPath.row].image,
                   let url = URL(string: urlString),
                   let data = try? Data(contentsOf: url) {
                    cell.avatarView.image = UIImage(data: data)
                } else {
                    cell.avatarView.image = UIImage(systemName: "person.circle.fill")
                }
            
        if let nameText = charactersSearch[indexPath.row].name,
           let genderText = charactersSearch[indexPath.row].gender,
           let speciesText = charactersSearch[indexPath.row].species,
           let locationText = charactersSearch[indexPath.row].location,
           let locationNameText = locationText.name {
                cell.nameLabel.text = "Name: " + nameText
                cell.genderLabel.text = "Gender: " + genderText
                cell.locationLabel.text = "Location: " + locationNameText
                cell.speciesLabel.text = "Species: " + speciesText
        } else {
            cell.nameLabel.text = "Name: "
            cell.genderLabel.text = "Gender: "
            cell.locationLabel.text = "Location: "
            cell.speciesLabel.text = "Species: "
        }
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    // SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        charactersSearch = []
        
        if searchText.isEmpty {
            charactersSearch = characters
        } else {
            for character in characters {
                if character.name!.lowercased().contains(searchText.lowercased()) {
                    charactersSearch.append(character)
                }
            }
        }
        self.tableView.reloadData()
    }
}
