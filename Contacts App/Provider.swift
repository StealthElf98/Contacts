//
//  Provider.swift
//  Contacts App
//
//  Created by Sergej on 3.7.23..
//

import Foundation
import CoreData

final class Provider {
    static let shared = Provider()
    private let container : NSPersistentContainer
    
    var contextView : NSManagedObjectContext {
        container.viewContext
    }
    
    var newContext : NSManagedObjectContext {
        container.newBackgroundContext()
    }
    
    private init() {
        container = NSPersistentContainer(name: "ContactModel")
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { _, error in
            if let err = error {
                print("Error: \(err)")
            }
        }
    }
    
    func exists(_ contact: Contact, context: NSManagedObjectContext) -> Contact? {
        if let existingContact = try? context.existingObject(with: contact.objectID) {
            return existingContact as? Contact
        }
        return nil
    }
    
    func delete(_ contact: Contact, context: NSManagedObjectContext) {
        if let existingContact = exists(contact, context: context) {
            context.delete(existingContact)
            Task(priority: .background) {
                try await context.perform {
                    try context.save()
                }
            }
        }
    }
    
    func persist(context: NSManagedObjectContext) throws {
        if context.hasChanges {
            try context.save()
        }
    }
    
}
