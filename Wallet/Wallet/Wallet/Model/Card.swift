//
//  Card.swift
//  Wallet
//
//  Created by Taeyoun Lee on 2022/03/06.
//

import SwiftUI

// MARK: Sample Card Model and Data
struct Card: Identifiable {
    var id = UUID().uuidString
    var name: String
    var cardNumber: String
    var cardImage: String
    var color: String
}

var cards: [Card] = [
    Card(name: "iJustine", cardNumber: "4343 5687 7867 0978", cardImage: "Card1", color: "lightBlue"),
    Card(name: "Jenna", cardNumber: "5687 4343 7867 0978", cardImage: "Card2", color: "darkGray"),
    Card(name: "Jessica", cardNumber: "7867 4343 0978 5687", cardImage: "Card3", color: "lightRed"),
]
