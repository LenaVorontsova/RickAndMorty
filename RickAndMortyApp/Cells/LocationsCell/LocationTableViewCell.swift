//
//  LocationTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import SnapKit

enum ConstantsLocationsCell {
    static let leadLabels = 20
    static let trailLabels = -20
    static let topLabels = 5
}

final class LocationTableViewCell: UITableViewCell {
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    var typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    var dimensionLabel: UILabel = {
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
    
    private func configureConstraints() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(dimensionLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ConstantsLocationsCell.leadLabels)
            make.trailing.equalToSuperview().offset(ConstantsLocationsCell.trailLabels)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ConstantsLocationsCell.leadLabels)
            make.trailing.equalToSuperview().offset(ConstantsLocationsCell.trailLabels)
            make.top.equalTo(nameLabel.snp.bottom).offset(ConstantsLocationsCell.topLabels)
        }
        
        dimensionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ConstantsLocationsCell.leadLabels)
            make.trailing.equalToSuperview().offset(ConstantsLocationsCell.trailLabels)
            make.top.equalTo(typeLabel.snp.bottom).offset(ConstantsLocationsCell.topLabels)
        }
    }
}

extension LocationTableViewCell: ReusableView {
    static var identifier: String {
            return "locationsCell"
    }
}
