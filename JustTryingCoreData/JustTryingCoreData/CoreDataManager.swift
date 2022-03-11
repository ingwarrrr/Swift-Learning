//
//  CoreDataManager.swift
//  JustTryingCoreData
//
//  Created by Igor on 10.03.2022.
//

import CoreData
import Foundation

class CoreDataManager {
    // singleton
    static let instance = CoreDataManager()
    
    private init() {}
    
    func fetchedResultsController(entityName: String, keyForSort: String) ->  NSFetchedResultsController<NSFetchRequestResult> {
        let context = CoreDataManager.instance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "JustTryingCoreData")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
