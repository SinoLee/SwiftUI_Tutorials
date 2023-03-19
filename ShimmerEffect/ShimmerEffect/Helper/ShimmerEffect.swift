//
//  ShimmerEffect.swift
//  ShimmerEffect
//
//  Created by Taeyoun Lee on 2023/03/18.
//

import SwiftUI

extension View {
    @ViewBuilder
    func shimmer(_ config: ShimmerConfig) -> some View {
        self
            .modifier(ShimmerEffectHelper(config: config))
    }
}

fileprivate struct ShimmerEffectHelper: ViewModifier {
    // Shimmer Config
    var config: ShimmerConfig
    // Animation Properties
    @State private var moveTo: CGFloat = -0.7
    func body(content: Content) -> some View {
        content
        // Adding Shimmer Animation with the help of Masking Modifier
        // Hiding the Normal One and adding shimmer on instead
            .hidden()
            .overlay {
                // Changing tint color
                Rectangle()
                    .fill(config.tint)
                    .mask {
                        content
                    }
                    .overlay {
                        // Shimmer
                        GeometryReader {
                            let size = $0.size
                            let extraOffset = size.height / 2.5
                            
                            Rectangle()
                                .fill(config.highlight)
                                .mask {
                                    Rectangle()
                                    // Gradient for glowing at the center
                                        .fill(
                                            .linearGradient(colors: [.white.opacity(0), config.highlight.opacity(config.highlightOpacity), .white.opacity(0)], startPoint: .top, endPoint: .bottom)
                                        )
                                    // Adding blur
                                        .blur(radius: config.blur)
                                    // Rotating
                                        .rotationEffect(.init(degrees: -70))
                                    // Moving to the start
                                        .offset(x: moveTo > 0 ? extraOffset : -extraOffset)
                                        .offset(x: size.width * moveTo)
                                }
                        }
                        // Mask with the content
                        .mask {
                            content
                        }
                    }
                // Animating Movement
                    .onAppear {
                        DispatchQueue.main.async {
                            moveTo = 0.7
                        }
                    }
                    .animation(.linear(duration: config.speed).repeatForever(autoreverses: false), value: moveTo)
            }
    }
}

// Shimmer Config
struct ShimmerConfig {
    var tint: Color
    var highlight: Color
    var blur: CGFloat = 0
    var highlightOpacity: CGFloat = 1
    var speed: CGFloat = 2
}

struct ShimmerEffect_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

