//
//  CoreDataManager.swift
//  Boxing 247
//
//  Created by Omar on 16/04/2021.
//  Copyright © 2021 Omar. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    private static var manager: CoreDataManager?
    
    public static var shared: CoreDataManager {
        
        if manager == nil {
            manager = CoreDataManager()
        }
        return manager!
    }
    
    public var container: NSPersistentContainer
    private var backgroundContext: NSManagedObjectContext
    
    private init() {
        
        container = NSPersistentContainer(name: "Boxing247")
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = container.viewContext
        
        if AppStatus.isTesting {
            CoreDataManager.setInMemoryStoreType(for: container)
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if AppStatus.isTesting {
                precondition(storeDescription.type == NSInMemoryStoreType)
            }
            
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    static func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        
        let backgroundContext = CoreDataManager.shared.backgroundContext
        backgroundContext.perform {
            block(backgroundContext)
        }
    }
    
    static func performViewTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        
        block(CoreDataManager.shared.container.viewContext)
    }
    
    func save() {
        
        try? backgroundContext.save()
        container.viewContext.performAndWait {

            try? container.viewContext.save()
        }
    }
    
    static func setInMemoryStoreType(for container: NSPersistentContainer) {
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
    }
}


struct AppStatus {
    
    static let isTesting = UserDefaults.standard.bool(forKey: "isTest")
}
