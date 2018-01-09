//
//  Character+CoreDataProperties.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 1/2/18.
//  Copyright © 2018 Nada Kamel. All rights reserved.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var resourceURI: String?
    @NSManaged public var thumbnail: String?

}
