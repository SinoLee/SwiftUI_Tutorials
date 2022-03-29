//
//  MeditationViewModel.swift
//  MusicPlayer
//
//  Created by Taeyoun Lee on 2022/03/28.
//

import SwiftUI

final class MeditationViewModel: ObservableObject {
    private(set) var meditation: Meditation
    
    init(meditation: Meditation) {
        self.meditation = meditation
    }
}

struct Meditation {
    let id = UUID()
    let title: String
    let description: String
    let duration: TimeInterval
    let track: String
    let image: String
    
    static let data = Meditation(title: "Making Progress", description: "Profound, deeply-captivating music for authentic stories. Expertly fuses ambient textures with heart-stirring melodies and the rich emotion of post-rock.", duration: 176, track: "making-progress-dan-phillipson-main-version-02-56-10491", image: "image-stones")
    // making-progress-dan-phillipson-main-version-02-56-10491.mp3
    // Play time : 2m 56s
    // Music from Uppbeat (free for Creators!):
    // https://uppbeat.io/t/dan-phillipson/making-progress
    // License code: IEMXARM6O71GZRPJ
    
    // image-stones.jpeg
    // Photo by <a href="https://unsplash.com/@bekirdonmeez?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Bekir Dönmez</a> on <a href="https://unsplash.com/s/photos/meditation?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
}
