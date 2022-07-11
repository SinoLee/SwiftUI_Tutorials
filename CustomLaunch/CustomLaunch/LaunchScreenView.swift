//
//  LaunchScreenView.swift
//  CustomLaunch
//
//  Created by Taeyoun Lee on 2022/07/11.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @State var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        }
        else {
            VStack {
                VStack {
                    Image("DigitalEagle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                    
                    Text("Digital Eagle")
                        .font(Font.custom("Baskerville-Bold", size: 26))
                        .foregroundColor(.black.opacity(0.8))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.1)) {
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
