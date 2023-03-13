//
//  Home.swift
//  CoreData_JSON
//
//  Created by Taeyoun Lee on 2023/03/05.
//

import SwiftUI
import CoreData

struct Home: View {
    // View Properties
    @State private var addExpense: Bool = false
    // Fetching core data entity
    @FetchRequest(entity: Purchase.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Purchase.dateOfPurchase, ascending: false)], animation: .easeInOut(duration: 0.3)) private var purchasedItems: FetchedResults<Purchase>
    @Environment(\.managedObjectContext) private var context
    // ShareSheet Properties
    @State private var presentShareSheet: Bool = false
    @State private var shareURL: URL = URL(string: "https://apple.com")!
    @State private var presentFilePicker: Bool = false
    var body: some View {
        NavigationStack {
            List {
                // Displaying Purchased Items
                ForEach(purchasedItems) { purchase in
                    HStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(purchase.title ?? "")
                                .fontWeight(.semibold)
                            Text((purchase.dateOfPurchase ?? .init()).formatted(date: .abbreviated, time: .omitted))
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer(minLength: 0)
                        
                        // Display currency
                        Text(currencyFormatter.string(from: NSNumber(value: purchase.amountSpent)) ?? "")
                            .fontWeight(.bold)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("My Expenses")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addExpense.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Button {
                            presentFilePicker.toggle()
                        } label: {
                            Text("Import")
                        }
                        Button {
                            exportCoreData()
                        } label: {
                            Text("Export")
                        }
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.init(degrees: -90))
                    }

                }
            }
            .sheet(isPresented: $addExpense) {
                AddNewExpense()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.hidden)
                    .interactiveDismissDisabled()
            }
            .sheet(isPresented: $presentShareSheet) {
                deleteTempFile()
            } content: {
                CustomShareSheet(url: $shareURL)
            }
            // File Importer (for selecting JSON file from files app)
            .fileImporter(isPresented: $presentFilePicker, allowedContentTypes: [.json]) { result in
                switch result {
                case .success(let success):
                    importJSON(success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
    }
    // Importing JSON file and adding to core data
    func importJSON(_ url: URL) {
        //print(url)
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.userInfo[.context] = context
            let items = try decoder.decode([Purchase].self, from: jsonData)
            // Since It's already loaded in context, simply save the context
            try context.save()
            print("File Imported successfully")
        } catch {
            // do action
            print(error)
        }
    }
    func deleteTempFile() {
        do {
            try FileManager.default.removeItem(at: shareURL)
            print("Removed Temp JSON File")
        } catch {
            print(error.localizedDescription)
        }
    }
    // Exporting core data to JSON file
    func exportCoreData() {
        do {
            // Step1
            // Fetching all core data
            if let entityName = Purchase.entity().name {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                let items = try context.fetch(request).compactMap {
                    $0 as? Purchase
                }
                // Step2
                // COnverting Items to JSON string file
                let jsonData = try JSONEncoder().encode(items)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    //print(jsonString) //for Debug
                    // Saving into temporary document and sharing it via sharesheet
                    if let tempURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                        let pathURL = tempURL.appending(component: "Export\(Date().formatted(date: .complete, time: .omitted)).json")
                        try jsonString.write(to: pathURL, atomically: true, encoding: .utf8)
                        // Saved Successfully
                        shareURL = pathURL
                        presentShareSheet.toggle()
                    }
                }
            }
        } catch {
            // Do Action
            print(error.localizedDescription)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomShareSheet: UIViewControllerRepresentable {
    @Binding var url: URL
    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: [url], applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
