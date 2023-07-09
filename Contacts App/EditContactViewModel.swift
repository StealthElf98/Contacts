//
//  EditContactViewModel.swift
//  Contacts App
//
//  Created by Sergej on 7.7.23..
//

import Foundation
import CoreData

class EditContactViewModel: ObservableObject {
    @Published var contact : Contact
    var isNew: Bool
    
    private let context : NSManagedObjectContext
    
    init(provider: Provider, contact : Contact? = nil) {
        self.context = provider.newContext
        if let contact, let existingContact = try? context.existingObject(with: contact.objectID) as? Contact{
            self.contact = existingContact
            isNew = false
        } else {
            self.contact = Contact(context: self.context)
            isNew = true
        }
        
    }
    
    func save() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
