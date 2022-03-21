//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Taeyoun Lee on 2022/03/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
