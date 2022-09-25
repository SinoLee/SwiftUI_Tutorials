//
//  Character.swift
//  DynamicScrollView
//
//  Created by Taeyoun Lee on 2022/09/25.
//

import Foundation
import SwiftUI

// MARK: Character model for holding data about each alphabet
struct Character: Identifiable {
    var id: String = UUID().uuidString
    var value: String
    var index: Int = 0
    var rect: CGRect = .zero
    var pusOffset: CGFloat = 0
    var isCurrent: Bool = false
    var color: Color = .clear
}
