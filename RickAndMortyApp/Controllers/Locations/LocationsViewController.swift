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
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationsCell") as! LocationTableViewCell

        cell.nameLabel.text = locationsSearch[indexPath.row].name
        cell.typeLabel.text = "Type: " + locationsSearch[indexPath.row].type!
        cell.dimensionLabel.text = "Dimension: " + locationsSearch[indexPath.row].dimension!
                    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        locationsSearch = []
        
        if searchText == "" {
            locationsSearch = locations
        } else {
            for location in locations {
                if ((location.name!.lowercased().contains(searchText.lowercased()))) {
                    locationsSearch.append(location)
                }
            }
        }
        self.tableView.reloadData()
    }
}
