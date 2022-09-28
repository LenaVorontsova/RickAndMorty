//
//  LocationTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import SnapKit

struct LocationTableViewCellModel {
    let name: String?
    let type: String?
    let dimension: String?
}

enum LocationTableViewCellFactory {
    static func cellModel(_ inf: LocationInfo) -> LocationTableViewCellModel {
        LocationTableViewCellModel(name: inf.name,
                                   type: R.string.cells.type(inf.type ?? ""),
                                   dimension: R.string.cells.dimension(inf.dimension ?? ""))
    }
}

final class LocationTableViewCell: UITableViewCell {
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var dimensionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    func config(with model: LocationTableViewCellModel) {
        nameLabel.text = model.name
        typeLabel.text = model.type
        dimensionLabel.text = model.dimension
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = R.color.backColor()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(R.string.cells.fatalError())
    }
    
    private func configureConstraints() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(dimensionLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ConstantsOfCells.offsetLabels)
            make.trailing.equalToSuperview().offset(-ConstantsOfCells.offsetLabels)
        }
        typeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ConstantsOfCells.offsetLabels)
            make.trailing.equalToSuperview().offset(-ConstantsOfCells.offsetLabels)
            make.top.equalTo(nameLabel.snp.bottom).offset(ConstantsOfCells.topLabels)
        }
        dimensionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ConstantsOfCells.offsetLabels)
            make.trailing.equalToSuperview().offset(-ConstantsOfCells.offsetLabels)
            make.top.equalTo(typeLabel.snp.bottom).offset(ConstantsOfCells.topLabels)
        }
    }
}

extension LocationTableViewCell: ReusableView {
    static var identifier: String {
            return R.string.cells.locationsCell()
    }
}
