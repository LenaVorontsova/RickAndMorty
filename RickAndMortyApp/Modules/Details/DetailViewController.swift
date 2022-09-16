//
//  DetailViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 15.09.2022.
//

import UIKit

enum ConstantsDetail {
    static let sizeAvatar = 200
    static let topAvatar = 10
    static let leadAvatar = 20
    
    static let leadLabels = 20
    static let trailLabels = -20
    static let topLabels = 5
}

final class DetailViewController: UIViewController {
    private var avatarView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureConstraints()
        
        view.backgroundColor = UIColor(red: 200 / 255, green: 246 / 255, blue: 236 / 255, alpha: 1)
    }
    
    private func configureConstraints() {
        view.addSubview(avatarView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        
        avatarView.snp.makeConstraints {
            $0.width.height.equalTo(ConstantsDetail.sizeAvatar)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(ConstantsDetail.topAvatar)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
                .offset(ConstantsDetail.leadAvatar)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
                .offset(ConstantsDetail.leadAvatar)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(avatarView.snp.bottom).offset(ConstantsDetail.topAvatar)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(ConstantsDetail.leadLabels)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(ConstantsDetail.trailLabels)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(ConstantsDetail.topLabels)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(ConstantsDetail.leadLabels)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(ConstantsDetail.trailLabels)
        }
    }
}
