//
//  CustomNavLink.swift
//  CustomNaviBar
//
//  Created by Taeyoun Lee on 2022/07/10.
//

import SwiftUI

struct CustomNavLink<Label:View, Destination:View>: View {
    
    let destination: Destination
    let label: Label
    
    init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination()
        self.label = label()
    }
    
    var body: some View {
        NavigationLink {
            CustomNavBarContainerView {
                destination
            }
            .navigationBarHidden(true)
        } label: {
            label
        }

    }
}

struct CustomNavLink_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            CustomNavLink {
                Text("Destination")
            } label: {
                Text("CLICK ME")
            }

        }
    }
}
