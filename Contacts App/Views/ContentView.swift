//
//  ContentView.swift
//  Contacts App
//
//  Created by Sergej on 29.6.23..
//

import SwiftUI

struct ContentView: View {
    @State var contactToEdit : Contact?
    @State var search: searchConfig = .init()
    var provider = Provider.shared
    @FetchRequest(fetchRequest: Contact.allContacts()) private var contacts
    
    var body: some View {
        NavigationStack {
            ZStack {
                if contacts.isEmpty {
                    Text("There is no contacts!")
                } else {
                    List {
                        ForEach(contacts) { item in
                            ZStack {
                                NavigationLink(destination: ContactDetailsView(contact: item)) {
                                    EmptyView()
                                }
                                .opacity(0)
                                ContactRowView(contact: item)
                                    .swipeActions(allowsFullSwipe: true) {
                                        Button(role: .destructive) {
                                            do {
                                                try deleteContact(item)
                                            } catch {
                                                print(error)
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                        
                                        Button {
                                            contactToEdit = item
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }
                                        .tint(.orange)
                                    }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        //Ne moze Contact() jer ce da pravi prazne kontakte
                        contactToEdit = Contact(context: provider.newContext)
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                    }
                }
            }
            .sheet(item: $contactToEdit, onDismiss: {
                contactToEdit = nil
            }, content: { contact in
                NavigationStack {
                    CreateContactView(vm: .init(provider: provider, contact: contact))
                }
            })
            .searchable(text: $search.query)
            .onChange(of: search) { newValue in
                contacts.nsPredicate = Contact.filterByName(newValue.query)
            }
        }
    }
}

struct searchConfig: Equatable {
    var query: String = ""
}

private extension ContentView {
    func deleteContact(_ contact: Contact) throws {
    let context = provider.contextView
    let existingContact = try context.existingObject(with: contact.objectID)
        context.delete(existingContact)
            Task(priority: .background) {
                try await context.perform {
                    try context.save()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
