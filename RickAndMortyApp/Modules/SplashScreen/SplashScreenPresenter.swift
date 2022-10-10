//
//  SplashScreenPresenter.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 01.09.2022.
//

import UIKit
import Alamofire

protocol SplashScreenPresenting: AnyObject {
    var controller: UIViewController? { get set }
    func showTabBar()
    func getInfo()
    func getInfoTest()
}

final class SplashScreenPresenter: SplashScreenPresenting {
    let network: NetworkService
    let search: SearchService
    let coreData: CoreDataService
    let analytics: AnalyticsServies
    let notifications: INotificationService
    weak var controller: UIViewController?
    
    init(network: NetworkService,
         search: SearchService,
         coreData: CoreDataService,
         analytics: AnalyticsServies,
         notifications: INotificationService) {
        self.network = network
        self.search = search
        self.coreData = coreData
        self.analytics = analytics
        self.notifications = notifications
    }
    
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
    
    func getInfo() {
        let infoGroup = DispatchGroup()
        let queue1 = DispatchQueue.global(qos: .utility)
        let queue2 = DispatchQueue.global(qos: .utility)
        let queue3 = DispatchQueue.global(qos: .utility)
        queue1.async(group: infoGroup) {
            infoGroup.enter()
            self.network.getInfoCharacters(endPoint: EndPoints.character.rawValue) { [weak self] result in
                switch result {
                case .success(let serverData):
                    guard let self = self else { return }
                    self.coreData.saveToCoreDataCharacter(charactersArray: serverData.results)
                    infoGroup.leave()
                case .failure(let error):
                    infoGroup.leave()
                    self!.showAlert(with: error)
                }
            }
        }
        queue2.async(group: infoGroup) {
            infoGroup.enter()
            self.network.getInfoLocations(endPoint: EndPoints.location.rawValue) { [weak self] result in
                switch result {
                case .success(let serverData):
                    guard let self = self else { return }
                    self.coreData.saveToCoreDataLocation(locationsArray: serverData.results)
                    infoGroup.leave()
                case .failure(let error):
                    infoGroup.leave()
                    self!.showAlert(with: error)
                }
            }
        }
        queue3.async(group: infoGroup) {
            infoGroup.enter()
            self.network.getInfoEpisodes(endPoint: EndPoints.episode.rawValue) { [weak self] result in
                switch result {
                case .success(let serverData):
                    guard let self = self else { return }
                    self.coreData.saveToCoreDataEpisodes(episodesArray: serverData.results)
                    infoGroup.leave()
                case .failure(let error):
                    infoGroup.leave()
                    self!.showAlert(with: error)
                }
            }
        }
        infoGroup.notify(queue: DispatchQueue.main) {
            self.showTabBar()
        }
    }
    
    func getInfoTest() {
        self.network.getInfoTest { [weak self] result in
            switch result {
            case .success(let serverData):
                guard let self = self else { return }
                self.coreData.saveToCoreDataEpisodes(episodesArray: serverData.results)
            case .failure(let error):
                self!.showAlert(with: error)
            }
        }
        self.showTabBar()
    }
    
    func showTabBar() {
        let debugMenu = DebugMenuViewController(dataService: coreData)
        let tabBarVC = TabBarViewController(search: search,
                                            coreData: coreData,
                                            analytic: analytics,
                                            notifications: notifications,
                                            debugMenu: debugMenu)
        tabBarVC.modalPresentationStyle = .fullScreen
        controller?.present(tabBarVC, animated: false)
    }
}
