//
//  DebugMenuView.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 06.10.2022.
//

import Foundation
import UIKit

enum DebugConstants {
    static let topLabels = 10
}

final class DebugMenuViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Debug Menu"
        title.textColor = .black
        title.font = .systemFont(ofSize: 28)
        title.textAlignment = .center
        return title
    }()
    private lazy var cellsCountLabel: UILabel = {
        let title = UILabel()
        title.text = "cellsCountLabel"
        title.textColor = .black
        title.font = .systemFont(ofSize: 24)
        title.textAlignment = .center
        title.numberOfLines = 4
        return title
    }()
    private lazy var bitesInCoreDataCountLabel: UILabel = {
        let title = UILabel()
        title.text = "bitesInCoreDataCountLabel"
        title.textColor = .black
        title.font = .systemFont(ofSize: 24)
        title.textAlignment = .center
        return title
    }()
    private lazy var memoryCountLabel: UILabel = {
        let title = UILabel()
        title.text = "memoryCountLabel"
        title.textColor = .black
        title.font = .systemFont(ofSize: 24)
        title.textAlignment = .center
        return title
    }()
    var characterCount: Int
    var locationCount: Int
    var episodeCount: Int
    
    init(characterCount: Int, locationCount: Int, episodeCount: Int) {
        self.characterCount = characterCount
        self.locationCount = locationCount
        self.episodeCount = episodeCount
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureConstraints()
        setTitlesText()
    }
    
    private func configureConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(cellsCountLabel)
        view.addSubview(bitesInCoreDataCountLabel)
        view.addSubview(memoryCountLabel)
        titleLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets).offset(DebugConstants.topLabels)
        }
        cellsCountLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(DebugConstants.topLabels)
        }
        bitesInCoreDataCountLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(cellsCountLabel.snp.bottom).offset(DebugConstants.topLabels)
        }
        memoryCountLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(bitesInCoreDataCountLabel.snp.bottom).offset(DebugConstants.topLabels)
        }
    }
    
    private func getMemoryCount() -> String {
        let taskVMInfoCount = mach_msg_type_number_t(
            MemoryLayout<task_vm_info_data_t>.size / MemoryLayout<integer_t>.size)
        guard let offset = MemoryLayout.offset(of: \task_vm_info_data_t.min_address) else { return "Memory: NA" }
        let taskVMInfoRev1Count = mach_msg_type_number_t(offset / MemoryLayout<integer_t>.size)
        var info = task_vm_info_data_t()
        var count = taskVMInfoCount
        let kr = withUnsafeMutablePointer(to: &info) { infoPtr in
            infoPtr.withMemoryRebound(to: integer_t.self,
                                      capacity: Int(count)) { intPtr in
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), intPtr, &count)
            }
        }
        guard kr == KERN_SUCCESS,
              count >= taskVMInfoRev1Count else { return "Memory: NA" }
        let usedBytes = Float(info.phys_footprint)
        let usedBytesInt = UInt64(usedBytes)
        let usedMB = usedBytesInt / 1024 / 1024
        let usedMBAsString: String = "Memory: \(usedMB) MB"
        return usedMBAsString
    }
    
    private func setTitlesText() {
        cellsCountLabel.text = "Number of characters: \(self.characterCount) \nNumber of locations: \(self.locationCount) \nNumber of characters: \(self.episodeCount)"
        memoryCountLabel.text = getMemoryCount()
    }
}
