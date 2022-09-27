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
    static let trailAvatar = -20
    
    static let leadStack = 30
    static let topStack = 370
    static let spacingStack = 5
}

final class DetailViewController: UIViewController {
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
        let childVC = CarouselViewController(viewModel: viewModel)
        
        createChildViewController(childVC: childVC)
        
        addTitle()
        
        configureConstraints()

        view.backgroundColor = R.color.backColor()
    }
    
    private func createChildViewController(childVC: CarouselViewController) {
        self.addChild(childVC)
        childVC.didMove(toParent: self)
        
        setupController(childVC: childVC)
    }
    
    private func setupController(childVC: UIViewController) {
        view.addSubview(childVC.view)
        
        childVC.view.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
                .offset(ConstantsDetail.sizeAvatar + ConstantsDetail.topAvatar)
        }
    }
    
    private func addTitle() {
        guard let labels = viewModel.titleLabel else { return }
        for text in labels {
            let label = UILabel()
            label.text = text
            label.font = .systemFont(ofSize: 28)
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
    }
    
    private func configureConstraints() {
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(ConstantsDetail.topStack)
            $0.center.equalToSuperview()
        }
    }
}
