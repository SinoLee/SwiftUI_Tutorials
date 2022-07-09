//
//  ContentView.swift
//  NavigationSearchBar
//
//  Created by Taeyoun Lee on 2022/07/09.
//

import SwiftUI

struct ContentView: View {
    
    @State var filteredItems = apps
    
    var body: some View {
        
        CustomNavigationView(view: AnyView(Home(filteredItems: $filteredItems)), title: "SearchBar", placeHolder: "Apps, Games", largeTitle: true) { txt in
            // filterting Data...
            if txt.count > 0 {
                self.filteredItems = apps.filter { $0.name.lowercased().contains(txt.lowercased()) }
            }
            else {
                self.filteredItems = apps
            }
        } onCancel: {
            // Do your own code when search and canceled...
            self.filteredItems = apps
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
