// 
//  CharactersLocationData+CoreDataProperties.swift
//  
//
//  Created by Lena Vorontsova on 07.09.2022.
//
//

import Foundation
import CoreData

extension CharactersLocationData {

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<CharactersLocationData> {
        return NSFetchRequest<CharactersLocationData>(entityName: "CharactersLocationData")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var character: CharacterData?
}
