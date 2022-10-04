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
    private var analytic: AnalyticsServies
    
    init(search: SearchService, coreData: CoreDataService, analytic: AnalyticsServies) {
        self.search = search
        self.coreData = coreData
        self.analytic = analytic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(R.string.modules.fatalError())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
    }
    
    private func createTabBar() {
        let  characterVC = UINavigationController(rootViewController: CharacterBuilder.build(coreData: coreData,
                                                                                             search: search,
                                                                                             analytic: analytic))
        let locationVC = UINavigationController(rootViewController: LocationBuilder.build(coreData: coreData,
                                                                                          search: search,
                                                                                          analytic: analytic))
        let episodeVC = UINavigationController(rootViewController: EpisodeBuilder.build(coreData: coreData, 
                                                                                        search: search,
                                                                                        analytic: analytic))
        characterVC.title = R.string.modules.charTitle()
        locationVC.title = R.string.modules.locTitle()
        episodeVC.title = R.string.modules.episodeTitle()
        self.setViewControllers([characterVC, locationVC, episodeVC], animated: false)
        guard let items = self.tabBar.items else {
            return
        }
        let imagesNames = [R.string.modules.imageOne(), R.string.modules.imageTwo(), R.string.modules.imageThree()]
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: imagesNames[i])
        }
    }
}
