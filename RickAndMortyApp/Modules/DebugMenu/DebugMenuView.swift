//
//  DebugMenuView.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 06.10.2022.
//

import Foundation
import UIKit
import Rswift

enum DebugConstants {
    static let topLabels = 10
}

final class DebugMenuViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = R.string.modules.debugMenu()
        title.textColor = R.color.black()
        title.font = .systemFont(ofSize: 28)
        title.textAlignment = .center
        return title
    }()
    
    private lazy var cellsCountLabel: UILabel = {
        let title = UILabel()
        title.textColor = R.color.black()
        title.font = .systemFont(ofSize: 24)
        title.textAlignment = .center
        return title
    }()
    
    private lazy var bytesInCoreDataCountLabel: UILabel = {
        let title = UILabel()
        title.textColor = R.color.black()
        title.font = .systemFont(ofSize: 24)
        title.textAlignment = .center
        return title
    }()
    
    private lazy var memoryCountLabel: UILabel = {
        let title = UILabel()
        title.textColor = R.color.black()
        title.font = .systemFont(ofSize: 24)
        title.textAlignment = .center
        return title
    }()
    
    private lazy var switchOnOff: UISwitch = {
        let switchUI = UISwitch()
        switchUI.onTintColor = R.color.green()
        return switchUI
    }()
    
    var switchStatus = true
    private let dataService: IDataService
    private let userDefaults = UserDefaults.standard
    
    init(dataService: IDataService) {
        self.dataService = dataService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(R.string.modules.fatalError())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        switchOnOff.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
        configureConstraints()
        setTitlesText()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        switchOnOff.isOn = userDefaults.bool(forKey: "ChangeSwitch")
    }
    
    @objc
    func switchStateDidChange(_ sender: UISwitch!) {
        userDefaults.set(sender.isOn, forKey: "ChangeSwitch")
        switchStatus = sender.isOn
    }
    
    private func configureConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(cellsCountLabel)
        view.addSubview(bytesInCoreDataCountLabel)
        view.addSubview(memoryCountLabel)
        view.addSubview(switchOnOff)
        titleLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets).offset(DebugConstants.topLabels)
        }
        cellsCountLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(DebugConstants.topLabels)
        }
        bytesInCoreDataCountLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(cellsCountLabel.snp.bottom).offset(DebugConstants.topLabels)
        }
        memoryCountLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(bytesInCoreDataCountLabel.snp.bottom).offset(DebugConstants.topLabels)
        }
        switchOnOff.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.top.equalTo(memoryCountLabel.snp.bottom).offset(DebugConstants.topLabels)
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
    
    private func getBytesInCoreDataCount() -> String {
        let filePath = "/Users/admin/Desktop/стажировка/elena-rickandmorty-ios/RickAndMortyApp/RickAndMorty.xcdatamodeld"
        var fileSize: UInt64
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: filePath)
            let dict = attr as NSDictionary
            fileSize = dict.fileSize()
            let sizeString: String = "CoreData in memory: \(fileSize) bytes"
            return sizeString
        } catch {
            print("Error: \(error)")
        }
        return ""
    }
    
    private func setTitlesText() {
        cellsCountLabel.text = "Number of characters: \(self.dataService.characterCount) \nNumber of locations: \(self.dataService.locationCount) \nNumber of characters: \(self.dataService.episodeCount)"
        memoryCountLabel.text = getMemoryCount()
        bytesInCoreDataCountLabel.text = getBytesInCoreDataCount()
    }
}
