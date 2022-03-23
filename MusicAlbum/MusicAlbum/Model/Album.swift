//
//  Album.swift
//  MusicAlbum
//
//  Created by Taeyoun Lee on 2022/03/24.
//

import SwiftUI

// MARK: Album Model and Sample Albums
struct Album: Identifiable {
    var id = UUID().uuidString
    var name: String
    var image: String
    var isLiked: Bool = false
}

var stackAlbums: [Album] = [
    Album(name: "취중고백", image: "Album2"),
    Album(name: "듣고 싶을까", image: "Album3"),
    Album(name: "ELEVEN", image: "Album4"),
    Album(name: "YOUNG-LUV.COM", image: "Album6"),
]

var albums: [Album] = [
    
    Album(name: "INVU", image: "Album1", isLiked: true),
    Album(name: "취중고백", image: "Album2"),
    Album(name: "듣고 싶을까", image: "Album3"),
    Album(name: "ELEVEN", image: "Album4"),
    Album(name: "2021 쇼미더머니 10", image: "Album5", isLiked: true),
    Album(name: "YOUNG-LUV.COM", image: "Album6"),
    Album(name: "다정히 내 이름을 부르면", image: "Album7"),
    Album(name: "호랑이수월가", image: "Album8"),
    Album(name: "Next Level", image: "Album9", isLiked: true),
]
