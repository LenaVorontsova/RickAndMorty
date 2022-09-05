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
    weak var controller: UIViewController?
    
    init(network: NetworkService, search: SearchService) {
        self.network = network
        self.search = search
    }
    
    func getInfo() {
        let infoGroup = DispatchGroup()
        let queue1 = DispatchQueue.global(qos: .utility)
        let queue2 = DispatchQueue.global(qos: .utility)
        let queue3 = DispatchQueue.global(qos: .utility)
        
        let episodes = EpisodePresenter(network: network, search: search)
        let characters = CharacterPresenter(with: network, search: search)
        let locations = LocationPresenter(network: network, search: search)
        
        queue1.async(group: infoGroup) {
            characters.getInfoCharacter()
            print("get characters")
        }
        
        queue2.async(group: infoGroup) {
            locations.getInfoLocation()
            print("get locations")
        }
        
        queue3.async(group: infoGroup) {
            episodes.getInfoEpisodes()
            print("get episodes")
        }
        
        infoGroup.notify(queue: DispatchQueue.main) {
            print("all tasks executed")
        }
    }
    
    func showTabBar() {
        let tabBarVC = TabBarViewController(network: network, search: search)
        tabBarVC.modalPresentationStyle = .fullScreen
        controller?.present(tabBarVC, animated: false)
    }
}
