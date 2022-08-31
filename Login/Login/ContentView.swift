//
//  ContentView.swift
//  Login
//
//  Created by Taeyoun Lee on 2022/08/26.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        if logStatus {
            // MARK: Your Home view
            demoHome()
        }
        else {
            Login()
        }
    }
    
    @ViewBuilder
    func demoHome() -> some View {
//        NavigationStack {
        NavigationView {
            Text("Logged In")
                .navigationTitle("Multi-Login")
                .toolbar {
                    ToolbarItem {
                        Button {
                            try? Auth.auth().signOut()
                            GIDSignIn.sharedInstance.signOut()
                            withAnimation(.easeInOut) {
                                logStatus = false
                            }
                        } label: {
                            Text("Logout")
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
