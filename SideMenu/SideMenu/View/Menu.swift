//
//  Menu.swift
//  SideMenu
//
//  Created by Taeyoun Lee on 2022/05/22.
//

import SwiftUI

struct Menu: View {
    
    @Binding var isDark: Bool
    @Binding var isShow: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        isShow.toggle()
                    }
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.title3)
                }
                
                Spacer()

                Button {
                    
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.title3)
                }
            }
            .padding(.top)
            .padding(.bottom, 25)
            
            Image("User1")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            
            VStack(spacing: 12) {
                Text("Catherine")
                Text("Developer")
                    .font(.caption)
            }
            .padding(.top, 25)
            
            HStack(spacing: 22) {
                
                Image(systemName: "moon.fill")
                    .font(.title)
                
//                Toggle("Dark Mode", isOn: $isDark)
//                    .onChange(of: isDark) { newValue in
//                        let first = UIApplication.shared.connectedScenes
//                            .filter { $0.activationState == .foregroundActive }
//                            .first(where: { $0 is UIWindowScene })
//                            .flatMap({ $0 as? UIWindowScene })?.windows
//                            .first(where: \.isKeyWindow)
//                        first?.rootViewController?.view.overrideUserInterfaceStyle = newValue ? .dark : .light
//                    }
                Toggle(isOn: $isDark) {
                    Text("Dark Mode")
                        .fontWeight(.bold)
                }
                .onChange(of: isDark) { newValue in
                    let first = UIApplication.shared.connectedScenes
                        .filter { $0.activationState == .foregroundActive }
                        .first(where: { $0 is UIWindowScene })
                        .flatMap({ $0 as? UIWindowScene })?.windows
                        .first(where: \.isKeyWindow)
                    first?.rootViewController?.view.overrideUserInterfaceStyle = newValue ? .dark : .light
                }
            }
            .padding(.top, 25)

            menuList()
        }
        .foregroundColor(.primary)
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width / 1.5)
        .background((isDark ? Color.black : Color.white).edgesIgnoringSafeArea(.all))
        .overlay(Rectangle().stroke(Color.primary.opacity(0.1), lineWidth: 1).ignoresSafeArea().shadow(radius: 3))
    }
    
    func menuList() -> some View {
        ScrollView {
            Group {
                Button {
                    print("Story")
                } label: {
                    HStack(spacing: 22) {
                        Image(systemName: "pencil.and.outline")
                            .frame(width: 25, height: 25)
                            .foregroundColor(.yellow)
                        Text("Story")
                            .font(.subheadline)
                        Spacer()
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
                
                Button {
                    print("Chats")
                } label: {
                    HStack(spacing: 22) {
                        Image(systemName: "person.2")
                            .frame(width: 25, height: 25)
                            .foregroundColor(.red)
                        Text("Chats")
                            .font(.subheadline)
                        Spacer()
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
                
                Spacer()
                    .padding()
                
                Button {
                    print("Media and Photos")
                } label: {
                    HStack(spacing: 22) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .frame(width: 25, height: 25)
                            .foregroundColor(.purple)
                        Text("Media And Photos")
                            .font(.subheadline)
                        Spacer()
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)

                Button {
                    print("Settings And Privacy")
                } label: {
                    HStack(spacing: 22) {
                        Image(systemName: "gear")
                            .frame(width: 25, height: 25)
                            .foregroundColor(.green)
                        Text("Settings And Privacy")
                            .font(.subheadline)
                        Spacer()
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)

                Button {
                    print("Help Center")
                } label: {
                    HStack(spacing: 22) {
                        Image(systemName: "exclamationmark.bubble")
                            .frame(width: 25, height: 25)
                            .foregroundColor(.blue)
                        Text("Help Center")
                            .font(.subheadline)
                        Spacer()
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)

                Button {
                    print("Notifications")
                } label: {
                    HStack(spacing: 22) {
                        Image(systemName: "speaker.wave.3")
                            .frame(width: 25, height: 25)
                            .foregroundColor(.red)
                        Text("Notifications")
                            .font(.subheadline)
                        Spacer()
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)

                Spacer()
            }
            .padding(.vertical)
        }
    }
}

struct Menu_Previews: PreviewProvider {
    
    @State static var dark: Bool = false
    @State static var show: Bool = false

    static var previews: some View {
        HStack {
            Menu(isDark: $dark, isShow: $show)
            Spacer()
        }
    }
}
