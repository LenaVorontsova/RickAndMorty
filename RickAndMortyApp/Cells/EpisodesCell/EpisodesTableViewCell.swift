//
//  EpisodesTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import SnapKit

struct EpisodesTableViewCellModel {
    let name: String?
    let airDate: String?
    let season: String?
    let episode: String?
}

enum EpisodesTableViewCellFactory {
    static func cellModel(_ inf: EpisodeInfo) -> EpisodesTableViewCellModel {
        var season = ""
        var episode = ""
        if let range = inf.episode?.range(of: "E"),
           let episodeText = inf.episode {
            season = String(episodeText[..<range.lowerBound])
            episode = String(episodeText[range.lowerBound...])
        } else {
            season = "number"
            episode = "number"
        }
        return EpisodesTableViewCellModel(name: inf.name,
                                          airDate: "Air date: " + (inf.air_date ?? ""),
                                          season: "Season: " + season,
                                          episode: "Episode: " + episode)
    }
}

enum ConstantsEpisodesCell {
    static let leadLabels = 20
    static let trailLabels = -20
    static let topLabels = 5
}

final class EpisodesTableViewCell: UITableViewCell {
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    var airDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    var seasonLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    var episodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 200 / 255, green: 246 / 255, blue: 236 / 255, alpha: 1)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with model: EpisodesTableViewCellModel) {
        nameLabel.text = model.name
        airDateLabel.text = model.airDate
        seasonLabel.text = model.season
        episodeLabel.text = model.episode
    }
    
    private func configureConstraints() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(airDateLabel)
        contentView.addSubview(seasonLabel)
        contentView.addSubview(episodeLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ConstantsEpisodesCell.leadLabels)
            make.trailing.equalToSuperview().offset(ConstantsEpisodesCell.trailLabels)
        }
        
        airDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ConstantsEpisodesCell.leadLabels)
            make.trailing.equalToSuperview().offset(ConstantsEpisodesCell.trailLabels)
            make.top.equalTo(nameLabel.snp.bottom).offset(ConstantsEpisodesCell.topLabels)
        }
        
        seasonLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ConstantsEpisodesCell.leadLabels)
            make.trailing.equalToSuperview().offset(ConstantsEpisodesCell.trailLabels)
            make.top.equalTo(airDateLabel.snp.bottom).offset(ConstantsEpisodesCell.topLabels)
        }
        
        episodeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ConstantsEpisodesCell.leadLabels)
            make.trailing.equalToSuperview().offset(ConstantsEpisodesCell.trailLabels)
            make.top.equalTo(seasonLabel.snp.bottom).offset(ConstantsEpisodesCell.topLabels)
        }
    }
}

extension EpisodesTableViewCell: ReusableView {
    static var identifier: String {
            return "episodesCell"
    }
}
