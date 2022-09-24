//
//  ContentView.swift
//  MorphingAnimation
//
//  Created by Taeyoun Lee on 2022/09/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MorphingView()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
