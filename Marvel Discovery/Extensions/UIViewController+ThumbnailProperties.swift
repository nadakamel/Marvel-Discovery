//
//  UIViewController+ThumbnailProperties.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 1/3/18.
//  Copyright © 2018 Nada Kamel. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    // MARK: - Create Thumbnail Entity
    
    func createThumbnailEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
//        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
//        if let item = NSEntityDescription.insertNewObject(forEntityName: "Thumbnail", into: context) as? Thumbnail {
//            item.category = dictionary["category"] as? String
//            item.fk_character_id = dictionary["fk_character_id"] as! Int32
//            item.name = dictionary["name"] as? String
//            item.path = dictionary["path"] as? String
//            return item
//        }
        return nil
    }
    
    // MARK: - Save Thumbnail Data
    
    func saveThumbnailInCoreDataWith(array: [[String: AnyObject]]) {
//        _ = array.map{self.createThumbnailEntityFrom(dictionary: $0)}
//        do {
//            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
//            let thumbnails = self.fetchCharacterEntityData()
//            print("Thumbnail data saved. # of records: \(thumbnails.count)")
//        } catch let error {
//            print("ERROR SAVING: \(error)")
//        }
    }
    
    // MARK: - Fetch Thumbnail Data
    
    func fetchThumbnailEntityData() -> [Thumbnail] {
        let thumbnails  = [Thumbnail]()
//        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Thumbnail")
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "fk_character_id", ascending: true)]
//        do {
//            thumbnails = try context.fetch(fetchRequest) as! [Thumbnail]
//        } catch let error as NSError {
//            print("ERROR FETCHING DATA: \(error), \(error.userInfo)")
//        }
        return thumbnails
    }
    
    // MARK: - Fetch Thumbnail Data Per CharacterID
    
    func fetchThumbnailEntityDataPerCharacterID(characterID: Int32) -> [Thumbnail] {
        let thumbnails  = [Thumbnail]()
//        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Thumbnail")
//        fetchRequest.predicate = NSPredicate(format: "fk_character_id = \(characterID)")
//        do {
//            thumbnails = try context.fetch(fetchRequest) as! [Thumbnail]
//        } catch let error as NSError {
//            print("ERROR FETCHING DATA: \(error), \(error.userInfo)")
//        }
        return thumbnails
    }
    
    // MARK: - Delete Thumbnail Data
    
    func deleteThumbnailEntityData()  {
//        do {
//            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Thumbnail")
//            do {
//                let objects  = try context.fetch(fetchRequest) as? [Thumbnail]
//                _ = objects.map{$0.map{context.delete($0)}}
//                CoreDataStack.sharedInstance.saveContext()
//            } catch let error {
//                print("ERROR DELETING: \(error)")
//            }
//        }
    }
}

