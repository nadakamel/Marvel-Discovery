//
//  Character.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 16/02/2021.
//  Copyright © 2021 Nada Kamel. All rights reserved.
//

import Foundation
import ObjectMapper

final class Character: NSObject, Mappable {
    
    var id: Int = 0
    var name: String = ""
    var desc: String = ""
    var resourceURI: String = ""
    var thumbnail: String = ""
    
    override init() {
        
    }
    
    public required init?(map : Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        desc <- map["description"]
        resourceURI <- map["resourceURI"]
        thumbnail <- map["thumbnail"]
    }
    
    // Realm
    func initWithRealm(realm : CharacterRealm) {
        id = realm.id
        name = realm.name
        desc = realm.desc
        resourceURI = realm.resourceURI
        thumbnail = realm.thumbnail
    }
    
}
