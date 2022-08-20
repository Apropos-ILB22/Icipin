//
//  CoreDataManager.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 21/08/22.
//

import SwiftUI
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager() //singleton creational pattern
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    } //getter for context
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Icipin")
        persistentContainer.loadPersistentStores{(description, error) in
            if let error = error {
                fatalError("Cannot initialize Core Data because \(error)")
            }
        }
    }
    
    func saveContext(){
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
}