//
//  DebugMenuView.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 06.10.2022.
//

import Foundation
import UIKit

final class DebugMenuView: UIViewController {
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Debug Menu"
        title.textColor = .green
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        configureConstraints()
    }
    
    private func configureConstraints() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
        }
    }
}
