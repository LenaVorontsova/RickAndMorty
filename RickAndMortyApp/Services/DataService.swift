//
//  DataService.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 12.10.2022.
//

import Foundation
import Alamofire
import CoreData

final class DataService {
    weak var controller: UIViewController?
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var characterCount = 0
    var locationCount = 0
    var episodeCount = 0
    
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
        
        let infoGroup = DispatchGroup()
        let queue1 = DispatchQueue.global(qos: .utility)
        let queue2 = DispatchQueue.global(qos: .utility)
        let queue3 = DispatchQueue.global(qos: .utility)
        queue1.async(group: infoGroup) {
            infoGroup.enter()
            network.getInfoCharacters(endPoint: EndPoints.character.rawValue) { [weak self] result in
                switch result {
                case .success(let serverData):
                    self?.saveToCoreDataCharacter(charactersArray: serverData.results)
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
                    self?.saveToCoreDataLocation(locationsArray: serverData.results)
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
                    self?.saveToCoreDataEpisodes(episodesArray: serverData.results)
                    infoGroup.leave()
                case .failure(let error):
                    infoGroup.leave()
                    self?.showAlert(with: error)
                }
            }
        }
    }
    
    // From CoreDataService
    func saveToCoreDataCharacter(charactersArray: [CharacterNetwork]) {
        deleteAllData(R.string.services.characterData())
        let entityCharacters = NSEntityDescription.entity(forEntityName: R.string.services.characterData(),
                                                          in: self.context!)!
        let entityLocation = NSEntityDescription.entity(forEntityName: R.string.services.characterLocData(),
                                                        in: self.context!)!
        
        for element in charactersArray {
            let character = NSManagedObject(entity: entityCharacters, insertInto: self.context)
            let location = NSManagedObject(entity: entityLocation, insertInto: self.context)
            character.setValue(element.name, forKeyPath: R.string.services.name())
            character.setValue(element.gender, forKeyPath: R.string.services.gender())
            character.setValue(element.species, forKeyPath: R.string.services.species())
            location.setValue(element.location?.name, forKey: R.string.services.name())
            character.setValue(location, forKey: R.string.services.location())
            if let urlString = element.image,
               let url = URL(string: urlString),
               let data = try? Data(contentsOf: url) {
                character.setValue(data, forKey: R.string.services.image())
            }
            do {
                try self.context!.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        self.characterCount = charactersArray.count
    }
    
    func saveToCoreDataLocation(locationsArray: [LocationInfo]) {
        deleteAllData(R.string.services.locationData())
        let entity = NSEntityDescription.entity(forEntityName: R.string.services.locationData(), in: self.context!)!
        for element in locationsArray {
            let location = NSManagedObject(entity: entity, insertInto: self.context)
            location.setValue(element.name, forKeyPath: R.string.services.name())
            location.setValue(element.type, forKeyPath: R.string.services.type())
            location.setValue(element.dimension, forKeyPath: R.string.services.dimension())
            do {
                try self.context!.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        self.locationCount = locationsArray.count
    }
    
    func saveToCoreDataEpisodes(episodesArray: [EpisodeInfo]) {
        deleteAllData(R.string.services.episodeData())
        let entity = NSEntityDescription.entity(forEntityName: R.string.services.episodeData(), in: self.context!)!
        for element in episodesArray {
            let episode = NSManagedObject(entity: entity, insertInto: self.context)
            episode.setValue(element.name, forKeyPath: R.string.services.name())
            episode.setValue(element.air_date, forKeyPath: R.string.services.air_date())
            episode.setValue(element.episode, forKeyPath: R.string.services.episode())
            do {
                try self.context!.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        self.episodeCount = episodesArray.count
    }
    
    func fetchCharactersFromCoreData() -> [Character] {
        var arr: [Character] = []
        do {
            let newArr = try context!.fetch(CharacterData.fetchRequest())
            for element in newArr {
                var character = Character(name: nil, gender: nil, species: nil, location: nil, image: nil)
                let location = Location(name: nil, url: nil)
                character.name = element.name
                character.gender = element.gender
                character.location = location
                character.species = element.species
                character.location?.name = element.location?.name
                if let data = element.image {
                    character.image = UIImage(data: data)
                }
                arr.append(character)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return arr
    }
    
    func fetchLocationsFromCoreData() -> [LocationInfo] {
        var arr: [LocationInfo] = []
        do {
            let newArr = try context!.fetch(LocationData.fetchRequest())
            for element in newArr {
                var location = LocationInfo(name: nil, type: nil, dimension: nil)
                location.name = element.name
                location.type = element.type
                location.dimension = element.dimension
                arr.append(location)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return arr
    }
    
    func fetchEpisodesFromCoreData() -> [EpisodeInfo] {
        var arr: [EpisodeInfo] = []
        do {
            let newArr = try context!.fetch(EpisodeData.fetchRequest())
            for element in newArr {
                var episode = EpisodeInfo(name: nil, air_date: nil, episode: nil)
                episode.name = element.name
                episode.air_date = element.air_date
                episode.episode = element.episode
                arr.append(episode)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return arr
    }
    
    func deleteAllData(_ entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context!.execute(batchDeleteRequest)
        } catch {
            print(error)
        }
    }
}
