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
        if let range = inf.episode?.range(of: R.string.cells.e()),
           let episodeText = inf.episode {
            season = String(episodeText[..<range.lowerBound])
            episode = String(episodeText[range.lowerBound...])
        } else {
            season = R.string.cells.number()
            episode = R.string.cells.number()
        }
        return EpisodesTableViewCellModel(name: inf.name,
                                          airDate: R.string.cells.airData(inf.air_date ?? ""),
                                          season: R.string.cells.season(season),
                                          episode: R.string.cells.episode(episode))
    }
}

enum ConstantsOfCells {
    static let offsetLabels = 20
    static let topLabels = 5
}

final class EpisodesTableViewCell: UITableViewCell {
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    private lazy var airDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    private lazy var seasonLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    private lazy var episodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = R.color.backColor()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(R.string.cells.fatalError())
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
            make.leading.equalToSuperview().offset(ConstantsOfCells.offsetLabels)
            make.trailing.equalToSuperview().offset(-ConstantsOfCells.offsetLabels)
        }
        airDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ConstantsOfCells.offsetLabels)
            make.trailing.equalToSuperview().offset(-ConstantsOfCells.offsetLabels)
            make.top.equalTo(nameLabel.snp.bottom).offset(ConstantsOfCells.topLabels)
        }
        seasonLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ConstantsOfCells.offsetLabels)
            make.trailing.equalToSuperview().offset(-ConstantsOfCells.offsetLabels)
            make.top.equalTo(airDateLabel.snp.bottom).offset(ConstantsOfCells.topLabels)
        }
        episodeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ConstantsOfCells.offsetLabels)
            make.trailing.equalToSuperview().offset(-ConstantsOfCells.offsetLabels)
            make.top.equalTo(seasonLabel.snp.bottom).offset(ConstantsOfCells.topLabels)
        }
    }
}

extension EpisodesTableViewCell: ReusableView {
    static var identifier: String {
            return R.string.cells.episodesCell()
    }
}
