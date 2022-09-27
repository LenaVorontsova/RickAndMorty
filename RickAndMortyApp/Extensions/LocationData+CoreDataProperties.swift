//
//  LocationData+CoreDataProperties.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 07.09.2022.
//

import Foundation
import CoreData

extension LocationData {

    @nonobjc
    public class
    func fetchRequest() -> NSFetchRequest<LocationData> {
        return NSFetchRequest<LocationData>(entityName: "LocationData")
    }

    @NSManaged public var dimension: String?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
}
