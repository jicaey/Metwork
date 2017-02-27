//
//  DataStore.swift
//  Metwork
//
//  Created by Michael Young on 2/20/17.
//  Copyright © 2017 Michael Young. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    static let sharedInstance = DataStore()
    private init() {}
    
    var outboundData = [String : String]()
    
    var profileInput = [String : String]() {
        didSet {
            outboundData["displayName"] = profileInput["displayName"]
            print("ProfileInput Set: \(profileInput)")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLabel"), object: nil)
        }
    }
    
    // MARK: - UserDefaults
    func saveProfileData() {
        let defaults = UserDefaults.standard
        defaults.set(profileInput, forKey: "ProfileData")
        
//        for (key, value) in profileInput {
//            defaults.set(value, forKey: key)
//        }
    }
    
    func fetchProfileData() {
        let defaults = UserDefaults.standard
        let fetchedDict = defaults.dictionary(forKey: "ProfileData")
        
        if let fetchedDict = fetchedDict {
            profileInput = fetchedDict as! [String : String]
        }
        
        print(fetchedDict ?? [String : String]())
    }
    
    // MARK: - Core Data stack
    
    func deleteAllData() {
        let context = persistentContainer.viewContext
        let dataFetchRequest = NSFetchRequest<ProfileData>(entityName: "ProfileData")
        
        do {
            let fetchedData = try context.fetch(dataFetchRequest)
            for data in fetchedData {
                context.delete(data)
            }
        } catch {
            print("error deleting")
        }
    }

    func fetchProfileCoreData() {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<ProfileData>(entityName: "ProfileData")
        
        do {
            let fetchedData = try context.fetch(fetchRequest)
            print("FetchedData \(fetchedData.count)")
            
            // TODO: Unwrap
            for data in fetchedData {
                if data.displayName != nil {
                    print("\(data.displayName)")
                } else {
                    print("nil")
                }
            }
            
        } catch {
            print("Could not fetch ProfileData")
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Metwork")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
//        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
