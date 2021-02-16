//
//  CharacterRealm.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 16/02/2021.
//  Copyright © 2021 Nada Kamel. All rights reserved.
//

import RealmSwift

class CharacterRealm: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var desc = ""
    @objc dynamic var resourceURI = ""
    @objc dynamic var thumbnail = ""
    
    func create(_ character: Character) {
        id = character.id
        name = character.name
        desc = character.desc
        resourceURI = character.resourceURI
        thumbnail = character.thumbnail
    }

}
