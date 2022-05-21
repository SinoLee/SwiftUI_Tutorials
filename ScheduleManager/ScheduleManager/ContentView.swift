//
//  ContentView.swift
//  ScheduleManager
//
//  Created by Taeyoun Lee on 2022/05/13.
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
