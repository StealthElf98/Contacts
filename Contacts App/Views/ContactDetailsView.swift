//
//  ContactDetailsView.swift
//  Contacts App
//
//  Created by Sergej on 6.7.23..
//

import SwiftUI

struct ContactDetailsView: View {
    @ObservedObject var contact: Contact
    
    var body: some View {
        List {
            Section("General") {
                LabeledContent {
                    Text(contact.email)
                } label: {
                    Text("Email")
                }
                
                LabeledContent {
                    Text(contact.number)
                } label: {
                    Text("Phone number")
                }
                
                LabeledContent {
                    Text(contact.birthday, style: .date)
                } label: {
                    Text("Birthday")
                }
            }
            
            Section("Notes") {
                Text("asdsafasdgasgasgsagasgsagasgsa")
            }
        }
        .navigationTitle(contact.name)
    }
}

//struct ContactDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            ContactDetailsView()
//        }
//    }
//}
