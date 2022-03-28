//
//  ContentView.swift
//  DragAndDrop
//
//  Created by Taeyoun Lee on 2022/03/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Home()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
