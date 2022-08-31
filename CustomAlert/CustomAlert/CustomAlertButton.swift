//
//  CustomAlertButton.swift
//  CustomAlert
//
//  Created by Taeyoun Lee on 2022/08/02.
//

import SwiftUI

struct CustomAlertButton {
    let title: LocalizedStringKey
    var action: (() -> Void)? = nil
}

//struct CustomAlertButton_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomAlertButton()
//    }
//}
