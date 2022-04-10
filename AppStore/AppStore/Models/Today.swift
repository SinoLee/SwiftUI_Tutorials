//
//  Today.swift
//  AppStore
//
//  Created by Taeyoun Lee on 2022/04/10.
//

import SwiftUI

// MARK: Data Model and Sample Data
struct Today: Identifiable {
    var id = UUID().uuidString
    var name: String
    var description: String
    var logo: String
    var bannerTitle: String
    var platformTitle: String
    var artwork: String
    
}

var todayItems: [Today] = [
    
    Today(name: "LEGO Brawls", description: "Battle with friends online", logo: "Logo1", bannerTitle: "Smash your rivals in LEGO Brawls", platformTitle: "Apple Arcade", artwork: "Post1"),
    Today(name: "LEGO Brawls", description: "Battle with friends online", logo: "Logo2", bannerTitle: "Smash your rivals in LEGO Brawls", platformTitle: "Apple Arcade", artwork: "Post2"),
]

var dummyText = "아스팔트 9: 레전드에서 Ferrari, Porsche, Lamborghini, W Motors 등 수많은 세계적 브랜드와 전설급 일류 제조사의 자동차를 직접 운전해 보세요. 싱글 또는 멀티플레이 모드의 역동적이고 현실감 넘치는 장소에서 레이스를 즐기고, 실력을 자랑하고, 스턴트 액션에 도전하세요. 아스팔트 8: 에어본 제작진이 선사하는 짜릿한 레이싱 경험이 여러분을 찾아갑니다."
