//
//  StyleButton.swift
//  CustomAlert
//
//  Created by Taeyoun Lee on 2022/08/02.
//

import SwiftUI

struct StyleButton: View {
    //StyleButton(localized: button.title, size: .small, type: .capsule) {
    @State var localized: String
    @State var size: Font
    @State var type: Font
    var body: some View {
        Button {
            
        } label: {
            Text(localized)
        }
        .font(size)
        .font(type)

    }
}

//struct StyleButton_Previews: PreviewProvider {
//    static var previews: some View {
//        StyleButton()
//    }
//}
