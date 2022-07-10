//
//  ContentView.swift
//  CustomNaviBar
//
//  Created by Taeyoun Lee on 2022/07/09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color.orange.ignoresSafeArea()
                
                CustomNavLink {
                    Text("Destination")
                        .customNavigationTitle("Second Screen")
                        .customNavigationSubtitle("Subtitle should be showing!!")
                } label: {
                    Text("Navigation")
                }
            }
            .customNavBarItems(title: "New title", subtitle: "subtitle", backButtonHidden: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
