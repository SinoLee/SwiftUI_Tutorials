//
//  ContentView.swift
//  RecipeBook
//
//  Created by Taeyoun Lee on 2022/03/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabBar()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipesViewModel())
    }
}
