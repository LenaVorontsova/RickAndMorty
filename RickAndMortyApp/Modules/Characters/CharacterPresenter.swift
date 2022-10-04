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
}

final class CharacterPresenter: CharacterPresenting {
    var characters: [Character] = []
    var charactersSearch: [Character] = []
    weak var controller: (UIViewController & IViewControllers)?
    let coreData: CoreDataService
    let search: SearchService
    let analytic: AnalyticsServies
    
    init(with coreData: CoreDataService, search: SearchService, analytic: AnalyticsServies) {
        self.coreData = coreData
        self.search = search
        self.analytic = analytic
    }
    
    func getInfoCharacter() {
        self.characters = self.coreData.fetchCharactersFromCoreData()
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
}
