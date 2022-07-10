//
//  CustomNavBarContainerView.swift
//  CustomNaviBar
//
//  Created by Taeyoun Lee on 2022/07/09.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    
    let content: Content
    
    @State private var showBackButton: Bool = true
    @State private var title: String = ""
    @State private var subtitle: String? = nil

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(showBackButton: showBackButton, title: title, subtitle: subtitle)
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self) { title in
            self.title = title
        }
        .onPreferenceChange(CustomNavBarSubtitlePreferenceKey.self) { subtitle in
            self.subtitle = subtitle
        }
        .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKey.self) { hideBackButton in
            self.showBackButton = !hideBackButton
        }
    }
}

struct CustomNavBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarContainerView {
            ZStack {
                Color.green.ignoresSafeArea()
                
                Text("Hello")
                    .foregroundColor(.white)
                    .customNavigationTitle("New Title")
                    .customNavigationSubtitle("SubTitle")
                    .customNavigationBarBackButtonHidden(true)
            }
        }
    }
}
