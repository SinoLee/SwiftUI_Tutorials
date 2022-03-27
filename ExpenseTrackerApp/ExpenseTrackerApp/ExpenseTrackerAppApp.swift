//
//  ExpenseTrackerAppApp.swift
//  ExpenseTrackerApp
//
//  Created by Taeyoun Lee on 2022/03/26.
//

import SwiftUI

@main
struct ExpenseTrackerAppApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
