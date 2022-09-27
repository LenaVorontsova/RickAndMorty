//
//  CarouselViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 21.09.2022.
//

import Foundation
import UIKit

final class CarouselViewController: UIViewController {
    
    let viewModel: DetailViewModelProtocol
    
    private var gallaryCollectionView = GalaryCollectionView()
    let images: [UIImage] = [R.image.one()!, R.image.two()!, R.image.three()!]
    
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let indexPath = IndexPath(row: gallaryCollectionView.numberOfItems / 2, section: 0)
        self.gallaryCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureConstraints()
        gallaryCollectionView.setCells(cells: images)
        
        view.backgroundColor = R.color.backColor() 
    }
    
    private func configureConstraints() {
        view.addSubview(gallaryCollectionView)
        
        gallaryCollectionView.snp.makeConstraints {
            $0.width.height.equalTo(ConstantsDetail.sizeAvatar)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(ConstantsDetail.topAvatar)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
                .offset(ConstantsDetail.offsetAvatar)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
                .offset(-ConstantsDetail.offsetAvatar)
        }
    }
}
