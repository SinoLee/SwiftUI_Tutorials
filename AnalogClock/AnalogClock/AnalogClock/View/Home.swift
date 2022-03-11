//
//  Home.swift
//  AnalogClock
//
//  Created by Taeyoun Lee on 2022/03/11.
//

import SwiftUI

struct Home: View {
    @State var isDark: Bool = false
    var body: some View {
        
        NavigationView {
            HomeContent(isDark: $isDark)
                .navigationBarHidden(true)
                .preferredColorScheme(isDark ? .dark : .light)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HomeContent: View {
    @Binding var isDark: Bool
    let width = UIScreen.main.bounds.width
    @State var current_Time = Time(hour: 0, min: 0, sec: 0)
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Analog Clock")
                    .font(.title)
                    .fontWeight(.heavy)
                    //.foregroundColor(isDark ? .white : .black)
                
                Spacer(minLength: 0)
                
                Button {
                    isDark.toggle()
                } label: {
                    Image(systemName: isDark ? "sun.min.fill" : "moon.fill")
                        .font(.system(size: 22))
                        .foregroundColor(isDark ? .black : .white)
                        .padding()
                        //.background(isDark ? .white : .black)
                        .background(Color.primary)
                        .clipShape(Circle())
                }
            }
            .padding()
            
            Spacer(minLength: 0)
            
            ZStack {
                
                Circle()
                    .fill(Color("BG").opacity(0.1))
                
                ForEach(0..<60, id: \.self) { i in
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 2, height: (i % 5) == 0 ? 15 : 5)
                        .offset(y: (width - 110) / 2)
                        .rotationEffect(.degrees(Double(i) * 6))
                }
                
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 2, height: (width - 180) / 2)
                    .offset(y: -(width - 180) / 4)
                    .rotationEffect(.degrees(Double(current_Time.sec) * 6))
                
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 4, height: (width - 200) / 2)
                    .offset(y: -(width - 200) / 4)
                    .rotationEffect(.degrees(Double(current_Time.min) * 6))

                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 4.5, height: (width - 240) / 2)
                    .offset(y: -(width - 240) / 4)
                    .rotationEffect(.degrees(Double(current_Time.hour) * 30 + Double(current_Time.min) * 0.5))

                Circle()
                    .fill(Color.primary)
                    .frame(width: 15, height: 15)
            }
            .frame(width: width - 80, height: width - 80)
            
            Spacer(minLength: 0)
        }
        .onAppear(perform: {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: Date())
            let min = calendar.component(.minute, from: Date())
            let sec = calendar.component(.second, from: Date())
            
            withAnimation(Animation.linear(duration: 0.01)) {
                current_Time = Time(hour: hour, min: min, sec: sec)
            }
        })
        .onReceive(receiver) { (_) in
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: Date())
            let min = calendar.component(.minute, from: Date())
            let sec = calendar.component(.second, from: Date())
            
            withAnimation(Animation.linear(duration: 0.01)) {
                current_Time = Time(hour: hour, min: min, sec: sec)
            }
        }
    }
}

struct Time {
    var hour: Int
    var min: Int
    var sec: Int
}
