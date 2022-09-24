//
//  MorphingView.swift
//  MorphingAnimation
//
//  Created by Taeyoun Lee on 2022/09/21.
//

import SwiftUI

struct MorphingView: View {
    // MARK: View Properties
    @State var currentImage: CustomShape = .cloud
    @State var pickerImage: CustomShape = .cloud
    @State var turnOffImageMorph: Bool = false
    @State var blurRadius: CGFloat = 0
    @State var animateMorph: Bool = false
    
    var body: some View {
        VStack {
            // MARK: Morphing Shapes with the Help of canvas and filters
            // Simply Mask the canvas shape as Image Mask
            GeometryReader { proxy in
                let size = proxy.size
                Image("Jeju")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(x: -20, y: -40)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .overlay(content: {
                        Rectangle()
                            .fill(.white)
                            .opacity(turnOffImageMorph ? 1 : 0)
                    })
                    .mask {
                        // MARK: Morphing shapes with the help of canvas and filters
                        Canvas { context, size in
                            // MARK: Morphing Filters
                            // For more morph shape link
                            // MARK: For more moph shape link change this
                            context.addFilter(.alphaThreshold(min: 0.4))
                            // MARK: This value plays major role in the morphing animation
                            // MARK: For reverse animation
                            // Until 20 -> it will be like 0-1
                            // After 20 till 40 -> it will be like 1-0
                            context.addFilter(.blur(radius: blurRadius >= 20 ? 20 - (blurRadius - 20) : blurRadius))
                            
                            // MARK: Draw Inside Layer
                            context.drawLayer { ctx in
                                if let resolvedImage = context.resolveSymbol(id: 1) {
                                    ctx.draw(resolvedImage, at: CGPoint(x: size.width / 2, y: size.height / 2), anchor: .center)
                                }
                            }
                        } symbols: {
                            // MARK: Giving Images with ID
                            ResolvedImage(currentImage: $currentImage)
                                .tag(1)
                        }
                        // MARK: Animations will not work in the canvas
                        // We can use Timeline View For those animations
                        // but here I'm going to simply use thmer to achive the same effect
                        .onReceive(Timer.publish(every: 0.007, on: .main, in: .common).autoconnect()) { _ in
                            if animateMorph {
                                if blurRadius <= 40 {
                                    // this is animation speed
                                    // you can change this for your own
                                    blurRadius += 0.5
                                    
                                    if blurRadius.rounded() == 20 {
                                        // MARK: Change of next image goes here
                                        currentImage = pickerImage
                                    }
                                }
                                
                                if blurRadius.rounded() == 40 {
                                    // MARK: end animation and reset the blur radius to zero
                                    animateMorph = false
                                    blurRadius = 0
                                }
                            }
                        }
                    }
            }
            .frame(height: 400)
            
            // MARK: - Segmented Picker
            Picker("", selection: $pickerImage) {
                ForEach(CustomShape.allCases, id: \.rawValue) { shape in
                    Image(systemName: shape.rawValue)
                        .tag(shape)
                }
            }
            .pickerStyle(.segmented)
            // MARK: Avoid top until the current animation is finished
            .overlay(content: {
                Rectangle()
                    .fill(.primary)
                    .opacity(animateMorph ? 0.05 : 0)
            })
            .padding(15)
            .padding(.top, -50)
            // MARK: When Even Picker Image Changes
            // Morphing Into New Shape
            .onChange(of: pickerImage) { newValue in
                animateMorph = true
            }
            
            Toggle("Turn Off Image Morph", isOn: $turnOffImageMorph)
                .fontWeight(.semibold)
                .padding(.horizontal, 15)
                .padding(.top, 10)
        }
        .offset(y: -50)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct ResolvedImage: View {
    @Binding var currentImage: CustomShape
    var body: some View {
        Image(systemName: currentImage.rawValue)
            .font(.system(size: 200))
            //.animation(.interactiveSpring(response: 0.7, dampingFraction: 0.0, blendDuration: 0.0), value: currentImage)
            .frame(width: 300, height: 300)
    }
}

struct MorphingView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
