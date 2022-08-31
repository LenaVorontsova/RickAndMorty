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
}

final class LocationPresenter: LocationPresenting {
    var locations: [LocationInfo] = []
    var locationsSearch: [LocationInfo] = []
    weak var controller: (UIViewController & IViewControllers)?
    let network: NetworkService
    let search: SearchService
    
    init(network: NetworkService, search: SearchService) {
        self.network = network
        self.search = search
    }
    
    func getInfoLocation() {
        network.getInfoLocations(endPoint: EndPoints.location.rawValue) { [weak self] result in
            switch result {
            case .success(let serverData):
            guard let self = self else { return }
                self.locations = serverData.results
                self.locationsSearch = self.locations
                self.controller?.reloadTable()
            case .failure(let error):
                self?.controller?.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func searchLocation(searchText: String) {
        locationsSearch = search.search(namable: locations,
                                        searchText: searchText,
                                        type: LocationInfo.self)
        controller?.reloadTable()
    }
}
