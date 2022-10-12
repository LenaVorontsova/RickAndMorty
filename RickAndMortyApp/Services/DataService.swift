//
//  DataService.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 12.10.2022.
//

import Foundation
import Alamofire

final class DataService {
    weak var controller: UIViewController?
    
    func showAlert(with error: AFError) {
        var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
        topWindow?.rootViewController = UIViewController()
        topWindow?.windowLevel = UIWindow.Level.alert + 1
        let alert = UIAlertController(title: R.string.alertMessages.errorTitle(),
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.alertMessages.okTitle(),
                                      style: .cancel) { _ in
            topWindow?.isHidden = true
            topWindow = nil
        })
        topWindow?.makeKeyAndVisible()
        topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func loadData() {
        let network = NetworkService()
        let coreData = CoreDataService()
        
        let infoGroup = DispatchGroup()
        let queue1 = DispatchQueue.global(qos: .utility)
        let queue2 = DispatchQueue.global(qos: .utility)
        let queue3 = DispatchQueue.global(qos: .utility)
        queue1.async(group: infoGroup) {
            infoGroup.enter()
            network.getInfoCharacters(endPoint: EndPoints.character.rawValue) { [weak self] result in
                switch result {
                case .success(let serverData):
                    coreData.saveToCoreDataCharacter(charactersArray: serverData.results)
                    infoGroup.leave()
                case .failure(let error):
                    infoGroup.leave()
                    self?.showAlert(with: error)
                }
            }
        }
        queue2.async(group: infoGroup) {
            infoGroup.enter()
            network.getInfoLocations(endPoint: EndPoints.location.rawValue) { [weak self] result in
                switch result {
                case .success(let serverData):
                    coreData.saveToCoreDataLocation(locationsArray: serverData.results)
                    infoGroup.leave()
                case .failure(let error):
                    infoGroup.leave()
                    self?.showAlert(with: error)
                }
            }
        }
        queue3.async(group: infoGroup) {
            infoGroup.enter()
            network.getInfoEpisodes(endPoint: EndPoints.episode.rawValue) { [weak self] result in
                switch result {
                case .success(let serverData):
                    coreData.saveToCoreDataEpisodes(episodesArray: serverData.results)
                    infoGroup.leave()
                case .failure(let error):
                    infoGroup.leave()
                    self?.showAlert(with: error)
                }
            }
        }
    }
}
