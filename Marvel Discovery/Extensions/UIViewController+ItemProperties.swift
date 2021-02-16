//
//  UIViewController+ItemProperties.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 1/3/18.
//  Copyright © 2018 Nada Kamel. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    // MARK: - Create Item Entity
    
    func createItemEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
//        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
//        if let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as? Item {
//            item.category = dictionary["category"] as? String
//            item.fk_character_id = dictionary["fk_character_id"] as! Int32
//            item.name = dictionary["name"] as? String
//            item.resourceURI = dictionary["resourceURI"] as? String
//            if (dictionary["type"] ?? nil) != nil {
//                item.type = dictionary["type"] as? String
//            }
//            return item
//        }
        return nil
    }
    
    // MARK: - Save Item Data
    
    func saveItemInCoreDataWith(array: [[String: AnyObject]]) {
//        _ = array.map{self.createItemEntityFrom(dictionary: $0)}
//        do {
//            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
//            let items = self.fetchCharacterEntityData()
//            print("Item data saved. # of records: \(items.count)")
//        } catch let error {
//            print("ERROR SAVING: \(error)")
//        }
    }
    
    // MARK: - Fetch Item Data
    
    func fetchItemEntityData() -> [Item] {
        let items  = [Item]()
//        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "fk_character_id", ascending: true)]
//        do {
//            items = try context.fetch(fetchRequest) as! [Item]
//        } catch let error as NSError {
//            print("ERROR FETCHING DATA: \(error), \(error.userInfo)")
//        }
        return items
    }
    
    // MARK: - Fetch Item Data Per CharacterID
    
    func fetchItemEntityDataPerCharacterID(characterID: Int32) -> [Item] {
        let items  = [Item]()
//        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
//        fetchRequest.predicate = NSPredicate(format: "fk_character_id = \(characterID)")
//        do {
//            items = try context.fetch(fetchRequest) as! [Item]
//        } catch let error as NSError {
//            print("ERROR FETCHING DATA: \(error), \(error.userInfo)")
//        }
        return items
    }
    
    // MARK: - Delete Item Data
    
    func deleteItemEntityData()  {
//        do {
//            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
//            do {
//                let objects  = try context.fetch(fetchRequest) as? [Item]
//                _ = objects.map{$0.map{context.delete($0)}}
//                CoreDataStack.sharedInstance.saveContext()
//            } catch let error {
//                print("ERROR DELETING: \(error)")
//            }
//        }
    }
}

