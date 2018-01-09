//
//  Item+CoreDataProperties.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 1/2/18.
//  Copyright © 2018 Nada Kamel. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }
    
    @NSManaged public var category: String?
    @NSManaged public var fk_character_id: Int32
    @NSManaged public var name: String?
    @NSManaged public var resourceURI: String?
    @NSManaged public var type: String?
 
}
