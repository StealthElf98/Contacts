//
//  Contacts_AppApp.swift
//  Contacts App
//
//  Created by Sergej on 29.6.23..
//

import SwiftUI

@main
struct Contacts_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, Provider.shared.contextView)
        }
    }
}
