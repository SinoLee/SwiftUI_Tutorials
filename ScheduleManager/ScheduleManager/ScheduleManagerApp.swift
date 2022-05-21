//
//  ScheduleManagerApp.swift
//  ScheduleManager
//
//  Created by Taeyoun Lee on 2022/05/13.
//

import SwiftUI

@main
struct ScheduleManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
