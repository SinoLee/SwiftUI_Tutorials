//
//  ContentView.swift
//  AnimationTabBar
//
//  Created by Taeyoun Lee on 2022/05/08.
//

import SwiftUI

struct ContentView: View {
    // MARK: Hiding Native One
    init() {
        UITabBar.appearance().isHidden = true
    }
    @State var currentTab: Tab = .bookmark
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Text("Bookmark")
                    .applyBG()
                    .tag(Tab.bookmark)
                Text("Time")
                    .applyBG()
                    .tag(Tab.time)
                Text("Camera")
                    .applyBG()
                    .tag(Tab.camera)
                Text("Chat")
                    .applyBG()
                    .tag(Tab.chat)
                Text("Settings")
                    .applyBG()
                    .tag(Tab.settings)
            }
            // MARK: Custom TabBar
            CustomTabBar(currentTab: $currentTab)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func applyBG() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color("BG")
                    .ignoresSafeArea()
            }
    }
}
