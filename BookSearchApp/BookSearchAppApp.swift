//
//  BookSearchAppApp.swift
//  BookSearchApp
//
//  Created by Sewell, Aramaea on 4/9/25.
//

import SwiftUI

@main
struct BookSearchAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
