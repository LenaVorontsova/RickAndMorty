//
//  DetailViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 15.09.2022.
//

import UIKit

enum ConstantsDetail {
    static let sizeAvatar = 250
    static let topAvatar = 10
    static let leadAvatar = 20
    
    static let leadStack = 20
    static let topStack = 10
    static let spacingStack = 5
}

final class DetailViewController: UIViewController {
    private var avatarView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = CGFloat(ConstantsDetail.spacingStack)
        return stack
    }()
    
    let viewModel: DetailViewModelProtocol
    
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImage()
        addTitle()
        
        configureConstraints()

        view.backgroundColor = UIColor(red: 200 / 255, green: 246 / 255, blue: 236 / 255, alpha: 1)
    }
    
    private func setupImage() {
        if let image = viewModel.image {
            avatarView.image = image
        } else {
            avatarView.image = UIImage(systemName: "person.3")
        }
    }
    
    private func addTitle() {
        guard let labels = viewModel.titleLabel else { return }
        for text in labels {
            let label = UILabel()
            label.text = text
            label.font = .systemFont(ofSize: 28)
            stackView.addArrangedSubview(label)
        }
    }
    
    private func configureConstraints() {
        view.addSubview(avatarView)
        view.addSubview(stackView)
        
        avatarView.snp.makeConstraints {
            $0.width.height.equalTo(ConstantsDetail.sizeAvatar)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(ConstantsDetail.topAvatar)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
                .offset(ConstantsDetail.leadAvatar)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(avatarView.snp.bottom).offset(ConstantsDetail.topStack)
            $0.leading.trailing.equalToSuperview().offset(ConstantsDetail.leadStack)
        }
    }
}
