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
        
        let service = Service(baseURL: "https://rickandmortyapi.com/api/")
        service.getInfoCharacters(endPoint: "character") { result in
            self.characters = result.results!
            self.charactersSearch = self.characters
            self.tableView.reloadData()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as! CharactersTableViewCell

            let url = URL(string: charactersSearch[indexPath.row].image!)
            let data = try? Data(contentsOf: url!)
            cell.avatarView.image = UIImage(data: data!)
            
            cell.nameLabel.text = "Name: " + charactersSearch[indexPath.row].name!
            cell.genderLabel.text = "Gender: " + charactersSearch[indexPath.row].gender!
            cell.locationLabel.text = "Location: " + charactersSearch[indexPath.row].location!.name!
            cell.speciesLabel.text = "Species: " + charactersSearch[indexPath.row].species!
            
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    // SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        charactersSearch = []
        
        if searchText == "" {
            charactersSearch = characters
        } else {
            for character in characters {
                if ((character.name!.lowercased().contains(searchText.lowercased()))) {
                    charactersSearch.append(character)
                }
            }
        }
        self.tableView.reloadData()
    }
}
