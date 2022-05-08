//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Taeyoun Lee on 2022/05/07.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
