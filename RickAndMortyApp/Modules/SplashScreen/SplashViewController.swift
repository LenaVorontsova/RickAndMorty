//
//  SplashViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 31.08.2022.
//

import UIKit

final class SplashViewController: UIViewController {
    let network: NetworkService
    let search: SearchService
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "splash")
        
        return image
    }()
    
    private var tabBarVC: UITabBarController = {
        let tabBar = UITabBarController()
    
        return tabBar
    }()
    
    init(with network: NetworkService, search: SearchService) {
        self.network = network
        self.search = search
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let  characterVC = UINavigationController(rootViewController: CharacterBuilder.build(network: network,
                                                                                             search: search))
        let locationVC = UINavigationController(rootViewController: LocationBuilder.build(network: network,
                                                                                          search: search))
        let episodeVC = UINavigationController(rootViewController: EpisodeBuilder.build(network: network,
                                                                                        search: search))
        
        characterVC.title = "Characters"
        locationVC.title = "Locations"
        episodeVC.title = "Episodes"
        
        tabBarVC.setViewControllers([characterVC, locationVC, episodeVC], animated: false)
        
        guard let items = tabBarVC.tabBar.items else {
            return
        }
        
        let imagesNames = ["person.3", "location.magnifyingglass", "play.rectangle"]
        
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: imagesNames[i])
        }
        
        tabBarVC.modalPresentationStyle = .fullScreen
        
        present(tabBarVC, animated: false)
    }
    
    private func configureConstraints() {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.height.width.equalToSuperview()
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
}
