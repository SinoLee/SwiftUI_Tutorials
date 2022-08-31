//
//  CustomAlert.swift
//  CustomAlert
//
//  Created by Taeyoun Lee on 2022/08/02.
//

import SwiftUI

struct CustomAlert: View {
    
    let title: String
    let message: String
    let dismissButton: CustomAlertButton?
    let primaryButton: CustomAlertButton?
    let secondaryButton: CustomAlertButton?
    
    //
    @State private var opacity: CGFloat = 0
    @State private var backgroundOpacity: CGFloat = 0
    @State private var scale: CGFloat = 0.001
    
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        ZStack {
            dimView
            
            alertView
                .scaleEffect(scale)
                .opacity(opacity)
        }
//        .clearBackground()
        .ignoresSafeArea()
//        .transition(.opacity)
        .task {
            animate(isShown: true)
        }
    }
    
    //
    private var alertView: some View {
        VStack(spacing: 20) {
            titleView
            messageView
            buttonsView
        }
        .padding(24)
        .frame(width: 320)
        .background(Color("neutral10"))
        .cornerRadius(12)
        .shadow(color: Color("neutral0").opacity(0.4), radius: 16, x: 0, y: 12)
    }
    
    @ViewBuilder
    private var titleView: some View {
        if !title.isEmpty {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(Color("neutral0"))
                .lineSpacing(24 - UIFont.systemFont(ofSize: 18, weight: .bold).lineHeight)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder
    private var messageView: some View {
        if !message.isEmpty {
            Text(message)
                .font(.system(size: title.isEmpty ? 18 : 16))
                .foregroundColor(title.isEmpty ? Color("neutral0") : Color("neutral1"))
                .lineSpacing(24 - UIFont.systemFont(ofSize: title.isEmpty ? 18 : 16).lineHeight)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var buttonsView: some View {
        HStack(spacing: 12) {
            if dismissButton != nil {
                dismissButtonView
            }
            else if primaryButton != nil, secondaryButton != nil {
                secondaryButtonView
                primaryButtonView
            }
        }
        .padding(.top, 23)
    }
    
    @ViewBuilder
    private var primaryButtonView: some View {
        if let button = primaryButton {
            StyleButton(localized: button.title, size: .small, type: .capsule) {
                animate(isShown: false) {
                    dismiss()
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    button.action?()
                }
            }
        }
    }
    
    @ViewBuilder
    private var secondaryButtonView: some View {
        if let button = primaryButton {
            StyleButton(localized: button.title, color: .neutral8, size: .small, type: .capsule) {
                animate(isShown: false) {
                    dismiss()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    button.action?()
                }
            }
        }
    }
    
    @ViewBuilder
    private var dismissButtonView: some View {
        if let button = dismissButton {
            StyleButton(localized: button.title, color: .neutral6, size: .medium) {
                animate(isShown: false) {
                    dismiss()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    button.action?()
                }
            }
        }
    }
    
    private var dimView: some View {
        Color("neutral7")
            .opacity(0.88)
            .opacity(backgroundOpacity)
    }
    
    // MARK: - Function
    private func animate(isShown: Bool, completion: (() -> Void)? = nil) {
        switch isShown {
        case true:
            opacity = 1
            
            withAnimation(.spring(response: 0.3, dampingFraction: 0.9, blendDuration: 0).delay(0.5)) {
                backgroundOpacity = 1
                scale = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completion?()
            }
            
        case false:
            withAnimation(.easeOut(duration: 0.2)) {
                backgroundOpacity = 0
                opacity = 0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                completion?()
            }
        }
    }
}

#if DEBUG
//struct CustomAlert_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomAlert()
//    }
//}
#endif
