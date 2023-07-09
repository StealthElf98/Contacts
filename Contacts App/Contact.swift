//
//  Contact.swift
//  Contacts App
//
//  Created by Sergej on 30.6.23..
//

import Foundation
import CoreData

final class Contact: NSManagedObject, Identifiable {
    @NSManaged var birthday: Date
    @NSManaged var email: String
    @NSManaged var isFavorite: Bool
    @NSManaged var lastname: String
    @NSManaged var name: String
    @NSManaged var notes: String
    @NSManaged var number: String
    
    var isBirthdayToday : Bool {
        Calendar.current.isDateInToday(birthday)
    }
    
    var isValid : Bool {
        !email.isEmpty && !lastname.isEmpty && !name.isEmpty && !number.isEmpty
    }
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        setPrimitiveValue(false, forKey: "isFavorite")
        setPrimitiveValue(Date.now, forKey: "birthday")
    }
        
    private static var contactsFatchRequest: NSFetchRequest<Contact> {
        NSFetchRequest(entityName: "Contact")
    	}
    
    static func allContacts() -> NSFetchRequest<Contact> {
        let request = contactsFatchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Contact.name, ascending: true)
        ]
        return request
    }
    
    static func filterByName(_ query: String) -> NSPredicate? {
        //[cd] = c oznacava da nije case sensitive, a d da se slova sa kukicama posmatraju kao bez (npr ç = c)
        query.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "name CONTAINS[cd] %@ || lastname CONTAINS[cd] %@", query, query)
    }
}
