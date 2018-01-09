//
//  Url+CoreDataProperties.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 1/2/18.
//  Copyright © 2018 Nada Kamel. All rights reserved.
//
//

import Foundation
import CoreData


extension Url {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Url> {
        return NSFetchRequest<Url>(entityName: "Url")
    }

    @NSManaged public var fk_character_id: Int32
    @NSManaged public var type: String?
    @NSManaged public var url: String?

}
