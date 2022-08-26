//
//  MainViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import SnapKit

enum Constants {
    static let imageSize: CGFloat = 210
    static let imageTop = 10
    static let imageLeadTrail = 20
    static let buttonHeight = 30
    
    static let characterTop = 44
    static let buttonsTop = 20
}

final class MainViewController: UIViewController {
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "rickAndMortyPreview")
        
        return image
    }()
    
    private var charactersButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Characters", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "person.3"), for: .normal)
        
        return button
    }()
    
    private var episodesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Episodes", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "play.rectangle"), for: .normal)
        
        return button
    }()
    
    private var locationsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Locations", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "location.magnifyingglass"), for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureController()
        configureConstraints()
    }
    
    private func configureController() {
        view.backgroundColor = UIColor(red: 200 / 255, green: 246 / 255, blue: 236 / 255, alpha: 1)
        charactersButton.addTarget(self, action: #selector(didTapCharactersButton), for: .touchUpInside)
        locationsButton.addTarget(self, action: #selector(didTapLocationsButton), for: .touchUpInside)
        episodesButton.addTarget(self, action: #selector(didTapEpisodesButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapCharactersButton() {
        navigationController?.show(CharacterViewController(), sender: nil)
    }
    
    @objc
    private func didTapLocationsButton() {
        navigationController?.show(LocationBuilder.build(), sender: nil)
    }
    
    @objc
    private func didTapEpisodesButton() {
        navigationController?.show(EpisodeBuilder.build(), sender: nil)
    }
    
    private func configureConstraints() {
        view.addSubview(imageView)
        view.addSubview(charactersButton)
        view.addSubview(locationsButton)
        view.addSubview(episodesButton)
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(Constants.imageSize)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.imageTop)
            make.leading.trailing.equalToSuperview().inset(Constants.imageLeadTrail)
        }
        
        charactersButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.top.equalTo(imageView.snp.bottom).offset(Constants.characterTop)
            make.centerX.equalToSuperview()
        }
        
        locationsButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.top.equalTo(charactersButton.snp.bottom).offset(Constants.buttonsTop)
            make.centerX.equalToSuperview()
        }
        
        episodesButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.top.equalTo(locationsButton.snp.bottom).offset(Constants.buttonsTop)
            make.centerX.equalToSuperview()
        }
    }
}
