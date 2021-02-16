//
//  RealmHelper.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 16/02/2021.
//  Copyright © 2021 Nada Kamel. All rights reserved.
//

import Foundation

class RealmHelper: NSObject {
    static func saveCharactersToRealm(characters: [Character]) {
        for character in characters {
            let characterRealm = CharacterRealm()
            characterRealm.create(character)
            RealmManager.sharedInstance.add([characterRealm])
        }
    }

    static func getRealmCharacters() -> [Character]? {
        let charactersRealm = RealmManager.sharedInstance.getAllDataForObject(CharacterRealm.self).map{$0 as! CharacterRealm}
        if charactersRealm.count > 0 {
            var characters = [Character]()
            for characterRealm in charactersRealm {
                let character = Character()
                character.initWithRealm(realm: characterRealm)
                characters.append(character)
            }
            return characters
        }
        return nil
    }

}
