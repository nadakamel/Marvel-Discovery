//
//  UrlRealm.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 16/02/2021.
//  Copyright © 2021 Nada Kamel. All rights reserved.
//

import RealmSwift

class UrlRealm: Object {
    
    @objc dynamic var fkCharacterID = 0
    @objc dynamic var type = ""
    @objc dynamic var urlPath = ""
    
    func create(_ url: Url) {
        fkCharacterID = url.fkCharacterID
        type = url.type
        urlPath = url.urlPath
    }

}
