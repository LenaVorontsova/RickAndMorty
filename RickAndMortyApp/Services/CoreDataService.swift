//
//  CoreDataService.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 06.09.2022.
//

import UIKit
import CoreData

final class CoreDataService {
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
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
