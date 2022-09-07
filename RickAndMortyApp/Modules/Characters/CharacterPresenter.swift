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
}

final class CharacterPresenter: CharacterPresenting {
    var characters: [Character] = []
    var charactersSearch: [Character] = []
    weak var controller: (UIViewController & IViewControllers)?
    let coreData: CoreDataService
    // let network: NetworkService
    let search: SearchService
    
    init(with coreData: CoreDataService, search: SearchService) {
        self.coreData = coreData
        self.search = search
    }
    
    func getInfoCharacter() {
//        characters = fetchCha
//        network.getInfoCharacters(endPoint: EndPoints.character.rawValue) { [weak self] result in
//            switch result {
//            case .success(let serverData):
//                guard let self = self else { return }
//                self.characters = serverData.results
//                self.charactersSearch = self.characters
//                self.controller?.reloadTable()
//            case .failure(let error):
//                self?.controller?.showAlert(message: error.localizedDescription)
//            }
//        }
        
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
}
