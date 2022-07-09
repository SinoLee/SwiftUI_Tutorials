//
//  Home.swift
//  NavigationSearchBar
//
//  Created by Taeyoun Lee on 2022/07/09.
//

import SwiftUI

struct Home: View {
    // for search bar...
    @Binding var filteredItems : [AppItem]
    
    var body: some View {
        // Apps List View ...
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 15) {
                // Apps List
                ForEach(filteredItems) { item in
                    
                    CardView(item: item)
                }
            }
            .padding()
        }
    }
}
