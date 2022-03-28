//
//  Character.swift
//  DragAndDrop
//
//  Created by Taeyoun Lee on 2022/03/27.
//

import SwiftUI

struct Character: Identifiable, Hashable, Equatable {
    let id = UUID().uuidString
    var value: String
    var padding: CGFloat = 10
    var textSize: CGFloat = .zero
    var fontSize: CGFloat = 19
    var isShowing: Bool = false
}

var characters_: [Character] = [
    Character(value: "Lorem"),
    Character(value: "Ipsum"),
    Character(value: "is"),
    Character(value: "simply"),
    Character(value: "dummy"),
    Character(value: "text"),
    Character(value: "of"),
    Character(value: "the"),
    Character(value: "design"),
]
