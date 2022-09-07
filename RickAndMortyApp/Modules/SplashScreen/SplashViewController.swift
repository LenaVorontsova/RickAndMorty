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
    private let presenter: SplashScreenPresenting
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "splash")
        
        return image
    }()
    
    init(with network: NetworkService, search: SearchService, presenter: SplashScreenPresenting) {
        self.network = network
        self.presenter = presenter
        self.search = search
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureConstraints()
        presenter.getInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // presenter.showTabBar()
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
