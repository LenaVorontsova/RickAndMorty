//
//  GalaryCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.09.2022.
//

import Foundation
import UIKit

final class GalaryCollectionViewCell: UICollectionViewCell {
    static let collectionCellId = "collectionCellId"
    
    let collectionImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContstrains() {
        addSubview(collectionImageView)
        
        collectionImageView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}
