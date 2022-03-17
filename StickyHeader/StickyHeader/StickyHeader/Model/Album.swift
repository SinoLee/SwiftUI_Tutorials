//
//  Album.swift
//  StickyHeader
//
//  Created by Taeyoun Lee on 2022/03/17.
//

import SwiftUI

// MARK: Album Model and Sample Data
struct Album: Identifiable {
    var id = UUID().uuidString
    var albumName: String
    var albumImage: String
    var isLiked: Bool = false
}

var albums: [Album] = [
    
    Album(albumName: "INVU", albumImage: "Album1", isLiked: true),
    Album(albumName: "취중고백", albumImage: "Album2"),
    Album(albumName: "듣고 싶을까", albumImage: "Album3"),
    Album(albumName: "ELEVEN", albumImage: "Album4"),
    Album(albumName: "2021 쇼미더머니 10", albumImage: "Album5", isLiked: true),
    Album(albumName: "YOUNG-LUV.COM", albumImage: "Album6"),
    Album(albumName: "다정히 내 이름을 부르면", albumImage: "Album7"),
    Album(albumName: "호랑이수월가", albumImage: "Album8"),
    Album(albumName: "Next Level", albumImage: "Album9", isLiked: true),
]
