//
//  Home.swift
//  SideMenu
//
//  Created by Taeyoun Lee on 2022/05/22.
//

import SwiftUI

struct Home: View {
    
    @State var dark = false
    @State var show = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            GeometryReader { _ in
                VStack {
                    ZStack {
                        HStack {
                            Button {
                                withAnimation {
                                    show.toggle()
                                }
                            } label: {
                                Image(systemName: "filemenu.and.selection")
                                    .font(.title3)
                            }
                            Spacer()
                        }
                        Text("Home")
                    }
                    .padding()
                    .foregroundColor(.primary)
                    .overlay(Rectangle().stroke(Color.primary.opacity(0.1), lineWidth: 1).shadow(radius: 3).edgesIgnoringSafeArea(.top))

                    Spacer()
                    
                    Text("Dark mode menu")
                    
                    Spacer()
                }
            }
            
            HStack {
                Menu(isDark: $dark, isShow: $show)
                    .preferredColorScheme(dark ? .dark : .light)
                    .offset(x: show ? 0 : -UIScreen.main.bounds.width / 1.5)

                Spacer(minLength: 0)
            }
            .background(Color.primary.opacity(show ? (dark ? 0.05 : 0.2) : 0).edgesIgnoringSafeArea(.all))
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
