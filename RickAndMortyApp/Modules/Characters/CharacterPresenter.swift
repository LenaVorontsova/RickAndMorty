//
//  CharacterPresenter.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.08.2022.
//

import UIKit
import Alamofire

protocol CharacterPresenting: AnyObject {
    var characters: [Character] { get set }
    var charactersSearch: [Character] { get set }
    func getInfoCharacter()
    func searchCharacter(searchText: String)
    func pathCharacterViewModel(indexPath: IndexPath) -> DetailViewModelProtocol
    func showNotification() -> UIAlertController
    func loadData()
}

final class CharacterPresenter: CharacterPresenting {
    var characters: [Character] = []
    var charactersSearch: [Character] = []
    weak var controller: (UIViewController & IViewControllers)?
    let dataService: DataService
    let search: SearchService
    let analytic: AnalyticsServies
    let notifications: INotificationService
    
    init(search: SearchService,
         analytic: AnalyticsServies,
         notifications: INotificationService,
         dataService: DataService) {
        self.search = search
        self.analytic = analytic
        self.notifications = notifications
        self.dataService = dataService
    }
    
    func loadData() {
        dataService.loadData()
    }
    
    func getInfoCharacter() {
        self.characters = self.dataService.fetchCharactersFromCoreData()
        self.charactersSearch = self.characters
        self.controller?.reloadTable()
    }
    
    func searchCharacter(searchText: String) {
        charactersSearch = search.search(namable: characters,
                                         searchText: searchText,
                                         type: Character.self)
        controller?.reloadTable()
    }
    
    func pathCharacterViewModel(indexPath: IndexPath) -> DetailViewModelProtocol {
        return CharacterViewModel(character: charactersSearch[indexPath.row], analytic: analytic)
    }
    
    func showNotification() -> UIAlertController {
        let alert = UIAlertController(title: "",
                                      message: "After 5 seconds local notification will appear",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.notifications.scheduleNotification(notificationType: "local notification")
        }
        alert.addAction(okAction)
        return alert
    }
}
