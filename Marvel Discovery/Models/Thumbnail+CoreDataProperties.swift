//
//  Thumbnail+CoreDataProperties.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 1/2/18.
//  Copyright © 2018 Nada Kamel. All rights reserved.
//
//

import Foundation
import CoreData


extension Thumbnail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Thumbnail> {
        return NSFetchRequest<Thumbnail>(entityName: "Thumbnail")
    }

    @NSManaged public var fk_character_id: Int32
    @NSManaged public var category: String?
    @NSManaged public var name: String?
    @NSManaged public var path: String?
    
}
