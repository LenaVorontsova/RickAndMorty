//
//  CharactersTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import SnapKit

enum ConstantsCharactersCell {
    static let sizeAvatar = 103
    static let leadAvatar = 10
    
    static let leadLabels = 20
    static let trailLabels = -20
    static let topLabels = 5
}

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class CharactersTableViewCell: UITableViewCell {
    
    var avatarView: UIImageView = {
        let image: UIImageView = .init()
        return image
        
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    var genderLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    var speciesLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    var locationLabel: UILabel = {
        let label: UILabel = .init()
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
    
    private func configureConstraints() {
        contentView.addSubview(avatarView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(genderLabel)
        contentView.addSubview(speciesLabel)
        contentView.addSubview(locationLabel)
        
        avatarView.snp.makeConstraints { make in
            make.width.height.equalTo(ConstantsCharactersCell.sizeAvatar)
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading)
                .offset(ConstantsCharactersCell.leadAvatar)
        }
        
        nameLabel.snp.makeConstraints { make in
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
            return "CharacterCell"
    }
}
