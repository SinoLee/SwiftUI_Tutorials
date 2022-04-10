//
//  CustomCornerView.swift
//  AppStore
//
//  Created by Taeyoun Lee on 2022/04/10.
//

import SwiftUI

struct CustomCornerView: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
