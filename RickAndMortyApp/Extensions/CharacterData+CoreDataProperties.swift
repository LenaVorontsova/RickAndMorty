//
//  CharacterData+CoreDataProperties.swift
//  
//
//  Created by Lena Vorontsova on 07.09.2022.
//
//

import Foundation
import CoreData

extension CharacterData {

    @nonobjc
    public class
    func fetchRequest() -> NSFetchRequest<CharacterData> {
        return NSFetchRequest<CharacterData>(entityName: "CharacterData")
    }

    @NSManaged public var gender: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var species: String?
    @NSManaged public var location: CharactersLocationData?
}
