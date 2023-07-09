//
//  CreateContactView.swift
//  Contacts App
//
//  Created by Sergej on 7.7.23..
//

import SwiftUI

struct CreateContactView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var vm : EditContactViewModel
    @State var hasError : Bool = false
    
    var body: some View {
        List {
            Section("General") {
                TextField("Name", text: $vm.contact.name).keyboardType(.namePhonePad)
                TextField("Lastname", text: $vm.contact.lastname).keyboardType(.namePhonePad)
                TextField("Email", text: $vm.contact.email).keyboardType(.emailAddress)
                TextField("Phone Number", text: $vm.contact.number).keyboardType(.numberPad)
                DatePicker("Birthday",
                           selection: $vm.contact.birthday, displayedComponents: [.date])
                .datePickerStyle(.compact)
                Toggle("Favorite", isOn: $vm.contact.isFavorite)
            }
            
            Section("Notes") {
                TextField("", text: $vm.contact.notes, axis: .vertical)
            }
        }
        .navigationTitle(vm.isNew ? "New Contact" : "Edit Contact")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Done") {
                    validateInput()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .alert("Error", isPresented: $hasError, actions:{}) {
            Text("All fields must be filled!")
        }

    }
}

private extension CreateContactView {
    func validateInput() {
        if vm.contact.isValid {
            do {
                try vm.save()
                dismiss()
            } catch {
                print(error)
            }
        } else {
            hasError = true
        }
    }
}

//
//struct CreateContactView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            CreateContactView(vm: EditContactViewModel(provider: .shared))
//        }
//    }
//}
