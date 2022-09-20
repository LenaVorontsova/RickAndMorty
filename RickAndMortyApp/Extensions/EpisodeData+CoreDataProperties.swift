//
//  EpisodeData+CoreDataProperties.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 07.09.2022.
//
//

import Foundation
import CoreData

extension EpisodeData {

    @nonobjc
    public class
        func fetchRequest() -> NSFetchRequest<EpisodeData> {
            return NSFetchRequest<EpisodeData>(entityName: "EpisodeData")
        }

    @NSManaged public var air_date: String?
    @NSManaged public var episode: String?
    @NSManaged public var name: String?
}
