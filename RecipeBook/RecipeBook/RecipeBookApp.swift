//
//  RecipeBookApp.swift
//  RecipeBook
//
//  Created by Taeyoun Lee on 2022/03/29.
//

import SwiftUI

@main
struct RecipeBookApp: App {
    @StateObject var recipesViewModel = RecipesViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(recipesViewModel)
        }
    }
}
