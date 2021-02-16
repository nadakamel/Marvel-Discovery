//
//  Thumbnail.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 16/02/2021.
//  Copyright © 2021 Nada Kamel. All rights reserved.
//

import Foundation
import ObjectMapper

final class Thumbnail: NSObject, Mappable {
    
    var category: String = ""
    var fkCharacterID: Int = 0
    var name: String = ""
    var path: String = ""
    
    override init() {
        
    }
    
    public required init?(map : Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        category <- map["category"]
        fkCharacterID <- map["fk_character_id"]
        name <- map["name"]
        path <- map["path"]
    }
    
    // Realm
    func initWithRealm(realm : ThumbnailRealm) {
        category = realm.category
        fkCharacterID = realm.fkCharacterID
        name = realm.name
        path = realm.path
    }
    
}
