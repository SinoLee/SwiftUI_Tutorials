//
//  MusicPlayerApp.swift
//  MusicPlayer
//
//  Created by Taeyoun Lee on 2022/03/28.
//

import SwiftUI

@main
struct MusicPlayerApp: App {
    @StateObject var audioManager = AudioManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
        }
    }
}
