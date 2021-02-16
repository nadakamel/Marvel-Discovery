//
//  ThumbnailRealm.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 16/02/2021.
//  Copyright © 2021 Nada Kamel. All rights reserved.
//

import RealmSwift

class ThumbnailRealm: Object {
    
    @objc dynamic var category = ""
    @objc dynamic var fkCharacterID = 0
    @objc dynamic var name = ""
    @objc dynamic var path = ""
    
    func create(_ thumbnail: Thumbnail) {
        category = thumbnail.category
        fkCharacterID = thumbnail.fkCharacterID
        name = thumbnail.name
        path = thumbnail.path
    }

}
