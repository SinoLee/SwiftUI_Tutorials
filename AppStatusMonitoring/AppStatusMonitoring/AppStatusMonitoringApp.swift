//
//  AppStatusMonitoringApp.swift
//  AppStatusMonitoring
//
//  Created by Taeyoun Lee on 2022/03/25.
//

import SwiftUI
import Firebase

@main
struct AppStatusMonitoringApp: App {
    // MARK: Initializing Firebase
    init() {
        FirebaseApp.configure()
    }
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // MARK: Checking For background activity
        .onChange(of: scenePhase) { newValue in
            switch newValue {
            case .inactive, .background:
                // App Closed or minimised
                print("App Closed or minimised")
                updateUserStatus("offline")
            case .active:
                // App is active
                print("App is active")
                updateUserStatus("online")
                
            default:
                break
            }
        }
    }
    
    // MARK: Updating User Status
    func updateUserStatus(_ status: String) {
        let reference = Firestore.firestore().collection("Users")
        
        // Your user doc
        reference.document("xo5T0SuCbNeSPCvWfY6T").updateData([
            "status": status,
            "lastActive": Date()
        ])
    }
}
