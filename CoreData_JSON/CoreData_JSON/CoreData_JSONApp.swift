//
//  CoreData_JSONApp.swift
//  CoreData_JSON
//
//  Created by Taeyoun Lee on 2023/03/05.
//

import SwiftUI

@main
struct CoreData_JSONApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
