//
//  GalaryCollectionView.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.09.2022.
//

import Foundation
import UIKit

final class GalaryCollectionView: UICollectionView, UICollectionViewDelegate,
                                    UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var cells = [UIImage]()
    let numberOfItems = 1000
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        self.showsHorizontalScrollIndicator = false
        delegate = self
        dataSource = self
        register(GalaryCollectionViewCell.self,
                 forCellWithReuseIdentifier: GalaryCollectionViewCell.collectionCellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCells(cells: [UIImage]) {
        self.cells = cells
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GalaryCollectionViewCell.collectionCellId,
            for: indexPath) as? GalaryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.collectionImageView.image = cells[indexPath.row % cells.count]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
}
