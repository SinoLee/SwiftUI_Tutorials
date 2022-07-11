//
//  ContentView.swift
//  CustomLaunch
//
//  Created by Taeyoun Lee on 2022/07/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            
            Text("Digital Eagle")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .bold()
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
