//
//  DebugMenuView.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 06.10.2022.
//

import Foundation
import UIKit

enum DebugConstants {
    static let topLabels = 10
}

final class DebugMenuViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Debug Menu"
        title.textColor = .black
        title.font = .systemFont(ofSize: 28)
        title.textAlignment = .center
        return title
    }()
    private lazy var cellsCountLabel: UILabel = {
        let title = UILabel()
        title.text = "cellsCountLabel"
        title.textColor = .black
        title.font = .systemFont(ofSize: 24)
        title.textAlignment = .center
        title.numberOfLines = 4
        return title
    }()
    private lazy var bitesInCoreDataCountLabel: UILabel = {
        let title = UILabel()
        title.text = "bitesInCoreDataCountLabel"
        title.textColor = .black
        title.font = .systemFont(ofSize: 24)
        title.textAlignment = .center
        return title
    }()
    private lazy var memoryCountLabel: UILabel = {
        let title = UILabel()
        title.text = "memoryCountLabel"
        title.textColor = .black
        title.font = .systemFont(ofSize: 24)
        title.textAlignment = .center
        return title
    }()
    private let characterPresenter: CharacterPresenting
    private let locationPresenter: LocationPresenting
    private let episodePresenter: EpisodePresenting
    
    init(characterPresenter: CharacterPresenting,
         locationPresenter: LocationPresenting,
         episodePresenter: EpisodePresenting) {
        self.characterPresenter = characterPresenter
        self.locationPresenter = locationPresenter
        self.episodePresenter = episodePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureConstraints()
        setTitlesText()
    }
    
    private func configureConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(cellsCountLabel)
        view.addSubview(bitesInCoreDataCountLabel)
        view.addSubview(memoryCountLabel)
        titleLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets).offset(DebugConstants.topLabels)
        }
        cellsCountLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(DebugConstants.topLabels)
        }
        bitesInCoreDataCountLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(cellsCountLabel.snp.bottom).offset(DebugConstants.topLabels)
        }
        memoryCountLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(bitesInCoreDataCountLabel.snp.bottom).offset(DebugConstants.topLabels)
        }
    }
    
    private func setTitlesText() {
        let charactersCount = characterPresenter.characters.count
        let locationCount = locationPresenter.locations.count
        let episodeCount = episodePresenter.episodes.count
        cellsCountLabel.text = "Number of characters: \(charactersCount), Number of locations: \(locationCount), Number of characters: \(charactersCount)"
        
    }
}
