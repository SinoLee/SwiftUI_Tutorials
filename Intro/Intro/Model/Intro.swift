//
//  Intro.swift
//  Intro
//
//  Created by Taeyoun Lee on 2022/10/19.
//

import Foundation

struct Intro: Identifiable {
    let id: String = UUID().uuidString
    var imageName: String
    var title: String
}

var intros: [Intro] = [
    .init(imageName: "Image1", title: "Relax"),
    .init(imageName: "Image2", title: "Care"),
    .init(imageName: "Image3", title: "Mood Dairy"),
]

// MARK: Font String's
let sansBold = "WorkSans-Bold"
let sansSemiBold = "WorkSans-SemiBold"
let sansRegular = "WorkSans-Regular"

let dummyText = "RIBs is the cross-platform architecture framework behind many mobile apps at Uber. The name RIBs is short for Router, Interactor and Builder, which are core components of this architecture. This framework is designed for mobile apps with a large number of engineers and nested states."
