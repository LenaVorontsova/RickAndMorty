//
//  SplashScreenPresenter.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 01.09.2022.
//

import UIKit

protocol SplashScreenPresenting: AnyObject {
    var controller: UIViewController? { get set }
    func showTabBar()
    func getInfo()
}

final class SplashScreenPresenter: SplashScreenPresenting {
    let network: NetworkService
    let search: SearchService
    let coreData: CoreDataService
    
    weak var controller: UIViewController?
    
    init(network: NetworkService, search: SearchService, coreData: CoreDataService) {
        self.network = network
        self.search = search
        self.coreData = coreData
    }
    
    func getInfo() {
        let infoGroup = DispatchGroup()
        let queue1 = DispatchQueue.global(qos: .utility)
        let queue2 = DispatchQueue.global(qos: .utility)
        let queue3 = DispatchQueue.global(qos: .utility)
        
        queue1.async(group: infoGroup) {
            infoGroup.enter()
            self.network.getInfoCharacters(endPoint: EndPoints.character.rawValue) { [weak self] result in
                switch result {
                case .success(let serverData):
                    guard let self = self else { return }
                    self.coreData.saveToCoreDataCharacter(charactersArray: serverData.results)
                    infoGroup.leave()
                case .failure(let error):
                    self?.controller?.showAlert(message: error.localizedDescription)
                }
            }
            print("get characters")
        }
        
        queue2.async(group: infoGroup) {
            infoGroup.enter()
            self.network.getInfoLocations(endPoint: EndPoints.location.rawValue) { [weak self] result in
                switch result {
                case .success(let serverData):
                    guard let self = self else { return }
                    self.coreData.saveToCoreDataLocation(locationsArray: serverData.results)
                    infoGroup.leave()
                case .failure(let error):
                    self?.controller?.showAlert(message: error.localizedDescription)
                }
            }
            print("get locations")
        }
        
        queue3.async(group: infoGroup) {
            infoGroup.enter()
            self.network.getInfoEpisodes(endPoint: EndPoints.episode.rawValue) { [weak self] result in
                switch result {
                case .success(let serverData):
                    guard let self = self else { return }
                    self.coreData.saveToCoreDataEpisodes(episodesArray: serverData.results)
                    infoGroup.leave()
                case .failure(let error):
                    self?.controller?.showAlert(message: error.localizedDescription)
                }
            }
            print("get episodes")
        }
        
        infoGroup.notify(queue: DispatchQueue.main) {
            print("all tasks executed")
            self.showTabBar()
        }
    }
    
    func showTabBar() {
        let tabBarVC = TabBarViewController(network: network, search: search, coreData: coreData)
        tabBarVC.modalPresentationStyle = .fullScreen
        controller?.present(tabBarVC, animated: false)
    }
}
