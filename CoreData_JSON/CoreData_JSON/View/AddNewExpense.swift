//
//  AddNewExpense.swift
//  CoreData_JSON
//
//  Created by Taeyoun Lee on 2023/03/05.
//

import SwiftUI

struct AddNewExpense: View {
    // View Properties
    @State private var title: String = ""
    @State private var dateOfPurchase: Date = .init()
    @State private var amountSpent: Double = 0
    // Environment Properties
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var context
    var body: some View {
        NavigationStack {
            List {
                Section("Purchase Item") {
                    TextField("", text: $title)
                }
                
                Section("Date of Purchase") {
                    DatePicker("", selection: $dateOfPurchase, displayedComponents: [.date])
                        .labelsHidden()
                }
                
                Section("Amount Spent") {
                    // TODO: - Known Issue
                    // If the input value is not an integer, '0' will be entered.
                    TextField(value: $amountSpent, formatter: currencyFormatter) {
                    }
                    //TextField(value: $amountSpent, formatter: currencyFormatter)
                    .labelsHidden()
                    .keyboardType(.numberPad)
                }
            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addExpense()
                    } label: {
                        Text("Add")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
        .onChange(of: amountSpent, perform: { newValue in
            print("# amount : \(newValue)")
        })
        .onChange(of: title, perform: { newValue in
            print("# title : \(newValue)")
        })
    }
    
    // Adding New Expense to Core Data
    func addExpense() {
        do {
            let purchase = Purchase(context: context)
            purchase.id = .init()
            purchase.title = title
            purchase.dateOfPurchase = dateOfPurchase
            purchase.amountSpent = amountSpent
            print("## amount : \(amountSpent)")
            
            try context.save()
            // Dismissing after successful addition
            dismiss()
        } catch {
            // Do Action
            print(error.localizedDescription)
        }
    }
}

struct AddNewExpense_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Currency Number Formatter
let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.allowsFloats = false
    formatter.numberStyle = .currency
    return formatter
}()
