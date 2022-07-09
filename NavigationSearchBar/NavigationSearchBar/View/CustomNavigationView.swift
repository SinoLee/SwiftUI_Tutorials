//
//  CustomNavigationView.swift
//  NavigationSearchBar
//
//  Created by Taeyoun Lee on 2022/07/09.
//

import SwiftUI

struct CustomNavigationView: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return CustomNavigationView.Coordinator(parent: self)
    }
    
    // Just Change your view that requires search bar...
    var view: AnyView
    
    //
    var largeTitle: Bool
    var title: String
    var placeHolder: String
    
    // onSearch and onCancel Closures...
    var onSearch: (String) -> ()
    var onCancel: () -> ()
    
    init(view: AnyView, title: String, placeHolder: String = "Search", largeTitle: Bool = true, onSearch: @escaping (String) -> (), onCancel: @escaping () -> ()) {
        self.view = view
        self.title = title
        self.placeHolder = placeHolder
        self.largeTitle = largeTitle
        self.onSearch = onSearch
        self.onCancel = onCancel
    }
    
    // Integrating UIKit Navigation Controller with SwiftUI View...
    func makeUIViewController(context: Context) -> some UIViewController {
        
        // requires SwiftUI View...
        let childView = UIHostingController(rootView: view)
        
        let controller = UINavigationController(rootViewController: childView)
        
        // Nav Bar Data...
        controller.navigationBar.topItem?.title = title
        controller.navigationBar.prefersLargeTitles = largeTitle
        
        // search bar...
        let searchController = UISearchController()
        searchController.searchBar.placeholder = placeHolder
        
        // setting delegate...
        searchController.searchBar.delegate = context.coordinator
        
        // setting Search Bar in NaviBar...
        // disabling hide on scroll...
        
        // disabling dim bg...
        searchController.obscuresBackgroundDuringPresentation = false
        
        controller.navigationBar.topItem?.hidesSearchBarWhenScrolling = false
        controller.navigationBar.topItem?.searchController = searchController
        
        return controller
    }
    
//    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
//    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Updateing
        guard let naviController = uiViewController as? UINavigationController else { return }
        naviController.navigationBar.topItem?.title = title
        naviController.navigationBar.topItem?.searchController?.searchBar.placeholder = placeHolder
        naviController.navigationBar.prefersLargeTitles = largeTitle
    }
    
    // search Bar Delegate...
    class Coordinator: NSObject, UISearchBarDelegate {
        
        var parent: CustomNavigationView
        
        init(parent: CustomNavigationView) {
            self.parent = parent
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            // when text changes...
            self.parent.onSearch(searchText)
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            // when cancel button is clicked...
            self.parent.onCancel()
        }
    }
}
