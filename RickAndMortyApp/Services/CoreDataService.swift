//
//  CoreDataService.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 06.09.2022.
//

import UIKit
import CoreData

final class CoreDataService {
    var arrCharacters: [NSManagedObject] = []
    var arrLocations: [NSManagedObject] = []
    var arrEpisodes: [NSManagedObject] = []
    
    func saveToCoreDataCharacter(charactersArray: [Character]) {
        deleteAllData("CharacterData")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
          
        let managedContext = appDelegate.persistentContainer.viewContext
          
        let entityCharacters = NSEntityDescription.entity(forEntityName: "CharacterData", in: managedContext)!
        let entityLocation = NSEntityDescription.entity(forEntityName: "CharactersLocationData",
                                                        in: managedContext)!
          
        for element in charactersArray {
            let character = NSManagedObject(entity: entityCharacters, insertInto: managedContext)
            let location = NSManagedObject(entity: entityLocation, insertInto: managedContext)
            character.setValue(element.name, forKeyPath: "name")
            character.setValue(element.gender, forKeyPath: "gender")
            character.setValue(element.species, forKeyPath: "species")
            location.setValue(element.location?.name, forKey: "name")
            character.setValue(location, forKey: "location")
            character.setValue(element.image, forKeyPath: "image")
            
            do {
                try managedContext.save()
                arrCharacters.append(character)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func saveToCoreDataLocation(locationsArray: [LocationInfo]) {
        deleteAllData("LocationData")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
          
        let managedContext = appDelegate.persistentContainer.viewContext
          
        let entity = NSEntityDescription.entity(forEntityName: "LocationData", in: managedContext)!
          
        for element in locationsArray {
            let location = NSManagedObject(entity: entity, insertInto: managedContext)
            location.setValue(element.name, forKeyPath: "name")
            location.setValue(element.type, forKeyPath: "type")
            location.setValue(element.dimension, forKeyPath: "dimension")
            do {
                try managedContext.save()
                arrLocations.append(location)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func saveToCoreDataEpisodes(episodesArray: [EpisodeInfo]) {
        deleteAllData("EpisodeData")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
          
        let managedContext = appDelegate.persistentContainer.viewContext
          
        let entity = NSEntityDescription.entity(forEntityName: "EpisodeData", in: managedContext)!
        
        for element in episodesArray {
            let episode = NSManagedObject(entity: entity, insertInto: managedContext)
            episode.setValue(element.name, forKeyPath: "name")
            episode.setValue(element.air_date, forKeyPath: "air_date")
            episode.setValue(element.episode, forKeyPath: "episode")
            do {
                try managedContext.save()
                arrEpisodes.append(episode)
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
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CharacterData")
        do {
            let newArr = try managedContext.fetch(fetchRequest)
            print(newArr)
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
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LocationData")
        
        do {
            let newArr = try managedContext.fetch(fetchRequest)
            print(newArr)
            for element in newArr {
                var location = LocationInfo(name: nil, type: nil, dimension: nil)
                location.name = element.value(forKey: "name") as? String
                location.type = element.value(forKey: "type") as? String
                location.dimension = element.value(forKey: "dimension") as? String
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
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EpisodeData")
        
        do {
            let newArr = try managedContext.fetch(fetchRequest)
            print(newArr)
            for element in newArr {
                var episode = EpisodeInfo(name: nil, air_date: nil, episode: nil)
                episode.name = element.value(forKey: "name") as? String
                episode.air_date = element.value(forKey: "air_date") as? String
                episode.episode = element.value(forKey: "episode") as? String
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
