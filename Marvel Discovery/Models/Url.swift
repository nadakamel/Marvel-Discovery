//
//  Url.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 16/02/2021.
//  Copyright © 2021 Nada Kamel. All rights reserved.
//

import Foundation
import ObjectMapper

final class Url: NSObject, Mappable {
    
    var fkCharacterID: Int = 0
    var type: String = ""
    var urlPath: String = ""

    override init() {
        
    }
    
    public required init?(map : Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        fkCharacterID <- map["fk_character_id"]
        type <- map["type"]
        urlPath <- map["url"]
    }
    
    // Realm
    func initWithRealm(realm : UrlRealm) {
        fkCharacterID = realm.fkCharacterID
        type = realm.type
        urlPath = realm.urlPath
    }
    
}
