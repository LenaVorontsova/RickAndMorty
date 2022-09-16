//
//  LocationPresenter.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.08.2022.
//

import UIKit
import Alamofire

protocol LocationPresenting: AnyObject {
    var locations: [LocationInfo] { get set }
    var locationsSearch: [LocationInfo] { get set }
    func getInfoLocation()
    func searchLocation(searchText: String)
    func openDetails(indexPath: IndexPath)
}

final class LocationPresenter: LocationPresenting {
    var locations: [LocationInfo] = []
    var locationsSearch: [LocationInfo] = []
    weak var controller: (UIViewController & IViewControllers)?
    let coreData: CoreDataService
    let search: SearchService
    
    init(coreData: CoreDataService, search: SearchService) {
        self.coreData = coreData
        self.search = search
    }
    
    func getInfoLocation() {
        self.locations = self.coreData.fetchLocationsFromCoreData()
        self.locationsSearch = self.locations
        self.controller?.reloadTable()
    }
    
    func searchLocation(searchText: String) {
        locationsSearch = search.search(namable: locations,
                                        searchText: searchText,
                                        type: LocationInfo.self)
        controller?.reloadTable()
    }
    
    func openDetails(indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        controller?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
