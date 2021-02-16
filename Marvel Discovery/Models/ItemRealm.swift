//
//  ItemRealm.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 16/02/2021.
//  Copyright © 2021 Nada Kamel. All rights reserved.
//

import RealmSwift

class ItemRealm: Object {
    
    @objc dynamic var category = ""
    @objc dynamic var fkCharacterID = 0
    @objc dynamic var name = ""
    @objc dynamic var resourceURI = ""
    @objc dynamic var type = ""
    
    func create(_ item: Item) {
        category = item.category
        fkCharacterID = item.fkCharacterID
        name = item.name
        resourceURI = item.resourceURI
        type = item.type
    }

}
