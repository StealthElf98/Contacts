//
//  ContacRowView.swift
//  Contacts App
//
//  Created by Sergej on 6.7.23..
//

import SwiftUI

struct ContactRowView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var contact: Contact
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(contact.name)\(contact.isBirthdayToday ? "🎁" : "")")
                .font(.system(size: 26, design: .rounded).bold())
            Text(contact.lastname)
                .font(.system(size: 26, design: .rounded).bold())
            Text(contact.email)
                .font(.callout.bold())
            Text(contact.number)
                .font(.callout.bold())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .topTrailing) {
            Button {
                makePersonFavorite()
            } label: {
                Image(systemName: "star")
                    .font(.title3)
                    .symbolVariant(.fill)
                    .foregroundColor(contact.isFavorite ? .yellow : .gray.opacity(0.3))
            }
            .buttonStyle(.plain)
        }
    }
}

private extension ContactRowView {
    func makePersonFavorite() {
        do {
            contact.isFavorite.toggle()
            if managedObjectContext.hasChanges {
                try managedObjectContext.save()
            }
        } catch {
            print(error)
        }
    }
}

//
//struct ContacRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactRowView(contact: .init()	)
//    }
//}
