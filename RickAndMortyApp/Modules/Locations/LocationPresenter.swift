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
    func pathLocationViewModel(indexPath: IndexPath) -> DetailViewModelProtocol
    func loadData()
}

final class LocationPresenter: LocationPresenting {
    var locations: [LocationInfo] = []
    var locationsSearch: [LocationInfo] = []
    weak var controller: (UIViewController & IViewControllers)?
    let search: SearchService
    let analytic: AnalyticsServies
    let dataService: DataService
    
    init(search: SearchService, analytic: AnalyticsServies, dataService: DataService) {
        self.search = search
        self.analytic = analytic
        self.dataService = dataService
    }
    
    func loadData() {
        dataService.loadData()
    }
    
    func getInfoLocation() {
        self.locations = self.dataService.fetchLocationsFromCoreData()
        self.locationsSearch = self.locations
        self.controller?.reloadTable()
    }
    
    func searchLocation(searchText: String) {
        locationsSearch = search.search(namable: locations,
                                        searchText: searchText,
                                        type: LocationInfo.self)
        controller?.reloadTable()
    }
    
    func pathLocationViewModel(indexPath: IndexPath) -> DetailViewModelProtocol {
        return LocationViewModel(location: locationsSearch[indexPath.row], analytic: analytic)
    }
}
