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
    
    func saveToCoreDataCharacter(charactersArray: [Character]) {
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
            character.setValue(element.image, forKeyPath: R.string.services.image())
            
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
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
              return arr
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            let newArr = try managedContext.fetch(CharacterData.fetchRequest())
            for element in newArr {
                let characterData = element as? CharacterData
                var character = Character(name: nil, gender: nil, species: nil, location: nil, image: nil)
                let location = Location(name: nil, url: nil)
                character.name = characterData?.name
                character.gender = characterData?.gender
                character.location = location
                character.species = characterData?.species
                character.location?.name = characterData?.location?.name
                character.image = characterData?.image
                arr.append(character)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return arr
    }
    
    func fetchLocationsFromCoreData() -> [LocationInfo] {
        var arr: [LocationInfo] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return arr
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            let newArr = try managedContext.fetch(LocationData.fetchRequest())
            for element in newArr {
                let locationData = element as? LocationData
                var location = LocationInfo(name: nil, type: nil, dimension: nil)
                location.name = locationData?.name
                location.type = locationData?.type
                location.dimension = locationData?.dimension
                arr.append(location)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return arr
    }
    
    func fetchEpisodesFromCoreData() -> [EpisodeInfo] {
        var arr: [EpisodeInfo] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
              return arr
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            let newArr = try managedContext.fetch(EpisodeData.fetchRequest())
            for element in newArr {
                let episodeData = element as? EpisodeData
                var episode = EpisodeInfo(name: nil, air_date: nil, episode: nil)
                episode.name = episodeData?.name
                episode.air_date = episodeData?.air_date
                episode.episode = episodeData?.episode
                arr.append(episode)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return arr
    }
    
    func deleteAllData(_ entity: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.execute(batchDeleteRequest)
        } catch {
            print(error)
        }
    }
}
