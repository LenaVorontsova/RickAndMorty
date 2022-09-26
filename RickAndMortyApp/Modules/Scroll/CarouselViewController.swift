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
    let images: [UIImage] = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!]
    
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureConstraints()
        gallaryCollectionView.setCells(cells: images)

        view.backgroundColor = UIColor(red: 200 / 255, green: 246 / 255, blue: 236 / 255, alpha: 1)
    }
    
    private func configureConstraints() {
        view.addSubview(gallaryCollectionView)
        
        gallaryCollectionView.snp.makeConstraints {
            $0.width.height.equalTo(ConstantsDetail.sizeAvatar)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(ConstantsDetail.topAvatar)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
                .offset(ConstantsDetail.leadAvatar)
        }
    }
}
