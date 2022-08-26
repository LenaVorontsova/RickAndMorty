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
}

final class CharacterPresenter: CharacterPresenting {
    var characters: [Character] = []
    var charactersSearch: [Character] = []
    weak var controller: (UIViewController & ICharacterViewController)?
    
    func getInfoCharacter() {
        NetworkService.shared.getInfoCharacters(endPoint: EndPoints.character.rawValue) { [weak self] result in
            switch result {
            case .success(let serverData):
                guard let self = self else { return }
                self.characters = serverData.results
                self.charactersSearch = self.characters
                self.controller?.reloadTable()
            case .failure(let error):
                self?.controller?.showAlert(message: error.localizedDescription)
            }
        }
    }
}
