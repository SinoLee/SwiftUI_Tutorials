//
//  ContentView.swift
//  StickyHeader
//
//  Created by Taeyoun Lee on 2022/03/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
        // MARK: Always Dark Mode
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
