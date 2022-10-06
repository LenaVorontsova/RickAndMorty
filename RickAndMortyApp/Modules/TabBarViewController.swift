//
//  TabBarViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 01.09.2022.
//

import UIKit

final class TabBarViewController: UITabBarController {
    private let search: SearchService
    private let coreData: CoreDataService
    private let analytic: AnalyticsServies
    private let notifications: INotificationService
    private let characterPresenter: CharacterPresenting
    private let locationPresenter: LocationPresenting
    private let episodePresenter: EpisodePresenting
    
    init(search: SearchService,
         coreData: CoreDataService,
         analytic: AnalyticsServies,
         notifications: INotificationService) {
        self.search = search
        self.coreData = coreData
        self.analytic = analytic
        self.notifications = notifications
        self.characterPresenter = CharacterPresenter(with: self.coreData,
                                                     search: self.search,
                                                     analytic: self.analytic,
                                                     notifications: self.notifications)
        self.locationPresenter = LocationPresenter(coreData: self.coreData,
                                                   search: self.search,
                                                   analytic: self.analytic)
        self.episodePresenter = EpisodePresenter(coreData: self.coreData,
                                                 search: self.search,
                                                 analytic: self.analytic)
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
            rootViewController: CharacterBuilder.build(coreData: coreData,
                                                       search: search,
                                                       analytic: analytic,
                                                       notifications: notifications))
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
        let debugViewController = DebugMenuViewController(characterPresenter: self.characterPresenter,
                                                          locationPresenter: self.locationPresenter,
                                                          episodePresenter: self.episodePresenter)
        self.present(debugViewController, animated: true)
    }
}
