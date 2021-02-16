//
//  UIViewController+UrlProperties.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 1/3/18.
//  Copyright © 2018 Nada Kamel. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    // MARK: - Create Url Entity
    
    func createUrlEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
//        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
//        if let url = NSEntityDescription.insertNewObject(forEntityName: "Url", into: context) as? Url {
//            url.fk_character_id = dictionary["fk_character_id"] as! Int32
//            url.type = dictionary["type"] as? String
//            url.url = dictionary["url"] as? String
//            return url
//        }
        return nil
    }
    
    // MARK: - Save Url Data
    
    func saveUrlInCoreDataWith(array: [[String: AnyObject]]) {
//        _ = array.map{self.createUrlEntityFrom(dictionary: $0)}
//        do {
//            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
//            let urls = self.fetchUrlEntityData()
//            print("Url data saved. # of records: \(urls.count)")
//        } catch let error {
//            print("ERROR SAVING: \(error)")
//        }
    }
    
    // MARK: - Fetch Url Data
    
    func fetchUrlEntityData() -> [Url] {
        let urls  = [Url]()
//        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Url")
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "fk_character_id", ascending: true)]
//        do {
//            urls = try context.fetch(fetchRequest) as! [Url]
//        } catch let error as NSError {
//            print("ERROR FETCHING DATA: \(error), \(error.userInfo)")
//        }
        return urls
    }
    
    // MARK: - Fetch Url Data Per CharacterID
    
    func fetchUrlEntityDataPerCharacterID(characterID: Int32) -> [Url] {
        let urls  = [Url]()
//        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Url")
//        fetchRequest.predicate = NSPredicate(format: "fk_character_id = \(characterID)")
//        do {
//            urls = try context.fetch(fetchRequest) as! [Url]
//        } catch let error as NSError {
//            print("ERROR FETCHING DATA: \(error), \(error.userInfo)")
//        }
        return urls
    }
    
    // MARK: - Delete Url Data
    
    func deleteUrlEntityData()  {
//        do {
//            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Url")
//            do {
//                let objects  = try context.fetch(fetchRequest) as? [Url]
//                _ = objects.map{$0.map{context.delete($0)}}
//                CoreDataStack.sharedInstance.saveContext()
//            } catch let error {
//                print("ERROR DELETING: \(error)")
//            }
//        }
    }
}
