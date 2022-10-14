//
//  TabBarViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 01.09.2022.
//

import UIKit

final class TabBarViewController: UITabBarController {
    private let search: SearchService
    private let analytic: AnalyticsServies
    private let notifications: INotificationService
    private let debugViewController: DebugMenuViewController
    private let dataService: IDataService
    
    init(search: SearchService,
         analytic: AnalyticsServies,
         notifications: INotificationService,
         debugMenu: DebugMenuViewController,
         dataService: IDataService) {
        self.search = search
        self.analytic = analytic
        self.notifications = notifications
        self.debugViewController = debugMenu
        self.dataService = dataService
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
        let  characterVC = UINavigationController(
            rootViewController: CharacterBuilder.build(search: search,
                                                       analytic: analytic,
                                                       notifications: notifications,
                                                       dataService: dataService))
        let locationVC = UINavigationController(rootViewController: LocationBuilder.build(search: search,
                                                                                          analytic: analytic,
                                                                                          dataService: dataService))
        let episodeVC = UINavigationController(rootViewController: EpisodeBuilder.build(search: search,
                                                                                        analytic: analytic,
                                                                                        dataService: dataService))
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
        createGesture()
    }
    
    private func createGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didDoubleTap(_:)))
        tapGesture.numberOfTapsRequired = 5
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func didDoubleTap(_ gesture: UITapGestureRecognizer) {
        self.present(debugViewController, animated: true)
    }
}
