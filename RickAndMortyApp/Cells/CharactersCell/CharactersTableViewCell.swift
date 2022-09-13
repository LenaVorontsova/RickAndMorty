//
//  CharactersTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import SnapKit

struct CharactersTableViewCellModel {
    let name: String?
    let gender: String?
    let species: String?
    let location: String?
}

enum CharactersTableViewCellFactory {
    static func cellModel(_ inf: Character) -> CharactersTableViewCellModel {
        CharactersTableViewCellModel(name: R.string.cells.name(inf.name ?? ""),
                                     gender: R.string.cells.gender(inf.gender ?? ""),
                                     species: R.string.cells.species(inf.species ?? ""),
                                     location: R.string.cells.location(inf.location?.name ?? ""))
    }
}

enum ConstantsCharactersCell {
    static let sizeAvatar = 103
    static let topAvatar = 10
    static let leadAvatar = 10
    
    static let leadLabels = 20
    static let trailLabels = -20
    static let topLabels = 5
}

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

final class CharactersTableViewCell: UITableViewCell {
    
    var avatarView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    var genderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    var speciesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    var locationLabel: UILabel = {
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
        fatalError(R.string.cells.fatalError())
    }
    
    func config(with model: CharactersTableViewCellModel) {
        nameLabel.text = model.name
        genderLabel.text = model.gender
        speciesLabel.text = model.species
        locationLabel.text = model.location
    }
    
    private func configureConstraints() {
        contentView.addSubview(avatarView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(genderLabel)
        contentView.addSubview(speciesLabel)
        contentView.addSubview(locationLabel)
        
        avatarView.snp.makeConstraints { make in
            make.width.height.equalTo(ConstantsCharactersCell.sizeAvatar)
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(ConstantsCharactersCell.topAvatar)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading)
                .offset(ConstantsCharactersCell.leadAvatar)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ConstantsCharactersCell.topAvatar)
            make.leading.equalTo(avatarView.snp.trailing).offset(ConstantsCharactersCell.leadLabels)
            make.trailing.equalToSuperview().offset(ConstantsCharactersCell.trailLabels)
        }
        genderLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarView.snp.trailing).offset(ConstantsCharactersCell.leadLabels)
            make.trailing.equalToSuperview().offset(ConstantsCharactersCell.trailLabels)
            make.top.equalTo(nameLabel.snp.bottom).offset(ConstantsCharactersCell.topLabels)
        }
        speciesLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarView.snp.trailing).offset(ConstantsCharactersCell.leadLabels)
            make.trailing.equalToSuperview().offset(ConstantsCharactersCell.trailLabels)
            make.top.equalTo(genderLabel.snp.bottom).offset(ConstantsCharactersCell.topLabels)
        }
        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarView.snp.trailing).offset(ConstantsCharactersCell.leadLabels)
            make.trailing.equalToSuperview().offset(ConstantsCharactersCell.trailLabels)
            make.top.equalTo(speciesLabel.snp.bottom).offset(ConstantsCharactersCell.topLabels)
        }
    }
}

extension CharactersTableViewCell: ReusableView {
    static var identifier: String {
        return R.string.cells.characterCell()
    }
}
