//
//  UIViewController+CharacterProperties.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 1/3/18.
//  Copyright © 2018 Nada Kamel. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    // MARK: - Create Character Entity
    
    func createCharacterEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let character = NSEntityDescription.insertNewObject(forEntityName: "Character", into: context) as? Character {
            character.desc = dictionary["description"] as? String
            character.id = dictionary["id"] as! Int32
            character.name = dictionary["name"] as? String
            character.resourceURI = dictionary["resourceURI"] as? String
            character.thumbnail = dictionary["thumbnail"] as? String
            return character
        }
        return nil
    }
    
    // MARK: - Save Character Data
    
    func saveCharacterInCoreDataWith(array: [[String: AnyObject]]) {
        _ = array.map{self.createCharacterEntityFrom(dictionary: $0)}
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
            let characters = self.fetchCharacterEntityData()
            print("Character data saved. # of records: \(characters.count)")
        } catch let error {
            print("ERROR SAVING: \(error)")
        }
    }
    
    // MARK: - Fetch Character Data
    
    func fetchCharacterEntityData() -> [Character] {
        var characters  = [Character]()
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Character")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        do {
            characters = try context.fetch(fetchRequest) as! [Character]
        } catch let error as NSError {
            print("ERROR FETCHING DATA: \(error), \(error.userInfo)")
        }
        return characters
    }
    
    // MARK: - Delete Character Data
    
    func deleteCharacterEntityData()  {
        do {
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Character")
            do {
                let objects  = try context.fetch(fetchRequest) as? [Character]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
            } catch let error {
                print("ERROR DELETING: \(error)")
            }
        }
    }
}


