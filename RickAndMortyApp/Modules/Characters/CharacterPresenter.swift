//
//  CharacterPresenter.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 26.08.2022.
//

import UIKit
import Alamofire

protocol CharacterPresenting: AnyObject {
    var characters: [CharacterNetwork] { get set }
    var charactersSearch: [CharacterNetwork] { get set }
    var images: [ImageOfCharacter] { get set }
    func getInfoCharacter()
    func searchCharacter(searchText: String)
}

final class CharacterPresenter: CharacterPresenting {
    var characters: [CharacterNetwork] = []
    var charactersSearch: [CharacterNetwork] = []
    var images: [ImageOfCharacter] = []
    weak var controller: (UIViewController & IViewControllers)?
    let coreData: CoreDataService
    let search: SearchService
    
    init(with coreData: CoreDataService, search: SearchService) {
        self.coreData = coreData
        self.search = search
    }
    
    func getInfoCharacter() {
        self.characters = self.coreData.fetchCharactersFromCoreData()
        self.charactersSearch = self.characters
        self.images = self.coreData.fetchImage()
        self.controller?.reloadTable()
    }
    
    func searchCharacter(searchText: String) {
        charactersSearch = search.search(namable: characters,
                                         searchText: searchText,
                                         type: CharacterNetwork.self)
        controller?.reloadTable()
    }
}
