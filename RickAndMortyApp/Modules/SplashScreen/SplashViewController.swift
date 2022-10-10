//
//  SplashViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 31.08.2022.
//

import UIKit

final class SplashViewController: UIViewController {
    let search: SearchService
    private let presenter: SplashScreenPresenting
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.image = R.image.splash()
        return image
    }()
    
    init(search: SearchService, presenter: SplashScreenPresenting) {
        self.presenter = presenter
        self.search = search
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(R.string.modules.fatalError())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
        let coreData = CoreDataService()
        let debugMenu = DebugMenuViewController(dataService: coreData)
        if debugMenu.switchStatus {
            presenter.getInfo()
        } else {
            presenter.getInfoTest()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
