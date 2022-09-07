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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
          
        let managedContext = appDelegate.persistentContainer.viewContext
          
        let entity = NSEntityDescription.entity(forEntityName: "CharacterData", in: managedContext)!
          
        let character = NSManagedObject(entity: entity, insertInto: managedContext)
          
        for element in charactersArray {
            character.setValue(element.name, forKeyPath: "name")
            character.setValue(element.gender, forKeyPath: "gender")
            character.setValue(element.species, forKeyPath: "species")
            character.setValue(element.location, forKeyPath: "location")
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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
          
        let managedContext = appDelegate.persistentContainer.viewContext
          
        let entity = NSEntityDescription.entity(forEntityName: "LocationData", in: managedContext)!
          
        let location = NSManagedObject(entity: entity, insertInto: managedContext)
          
        for element in locationsArray {
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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
          
        let managedContext = appDelegate.persistentContainer.viewContext
          
        let entity = NSEntityDescription.entity(forEntityName: "EpisodeData", in: managedContext)!
          
        let episode = NSManagedObject(entity: entity, insertInto: managedContext)
          
        for element in episodesArray {
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
            if let newArr = try managedContext.fetch(fetchRequest) as? [Character] {
                arr = newArr
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
            if let newArr = try managedContext.fetch(fetchRequest) as? [LocationInfo] {
                arr = newArr
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
            if let newArr = try managedContext.fetch(fetchRequest) as? [EpisodeInfo] {
                arr = newArr
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return arr
    }
}
