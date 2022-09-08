//
//  TabBarViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 01.09.2022.
//

import UIKit

final class TabBarViewController: UITabBarController {
    private var search: SearchService
    private var coreData: CoreDataService
    
    init(search: SearchService, coreData: CoreDataService) {
        self.search = search
        self.coreData = coreData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
    }
    
    private func createTabBar() {
        let  characterVC = UINavigationController(rootViewController: CharacterBuilder.build(coreData: coreData,
                                                                                             search: search))
        let locationVC = UINavigationController(rootViewController: LocationBuilder.build(coreData: coreData,
                                                                                          search: search))
        let episodeVC = UINavigationController(rootViewController: EpisodeBuilder.build(coreData: coreData, 
                                                                                        search: search))
        
        characterVC.title = "Characters"
        locationVC.title = "Locations"
        episodeVC.title = "Episodes"
        
        self.setViewControllers([characterVC, locationVC, episodeVC], animated: false)
        
        guard let items = self.tabBar.items else {
            return
        }
        
        let imagesNames = ["person.3", "location.magnifyingglass", "play.rectangle"]
        
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: imagesNames[i])
        }
    }
}
