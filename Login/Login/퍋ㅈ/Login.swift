//
//  Login.swift
//  Login
//
//  Created by Taeyoun Lee on 2022/08/29.
//

import SwiftUI
// MARK: Integrating Apple Sign in
// See My apple sign in video for more detail procedure
// link in the description
import AuthenticationServices
import GoogleSignIn
import GoogleSignInSwift
import Firebase

struct Login: View {
    @StateObject var loginModel: LoginViewModel = .init()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 15) {
                Image(systemName: "triangle")
                    .font(.system(size: 30))
                    .foregroundColor(.indigo)
                
                (Text("Welcome")
                    .foregroundColor(.black) +
                Text("\nLogin to continue")
                    .foregroundColor(.gray)
                )
                .font(.title)
                .fontWeight(.semibold)
                .lineSpacing(10)
                .padding(.top, 20)
                .padding(.trailing, 16)
                
                // MARK: Custom TextField
                CustomTextField(hint: "1 6505551234", text: $loginModel.mobileNo)
                    .disabled(loginModel.showOTPField)
                    .opacity(loginModel.showOTPField ? 0.4 : 1)
                    .overlay(alignment: .trailing, content: {
                        Button {
                            withAnimation(.easeInOut) {
                                loginModel.showOTPField = false
                                loginModel.otpCode = ""
                                loginModel.clientCode = ""
                            }
                        } label: {
                            Text("Change")
                                .font(.caption)
                                .foregroundColor(.indigo)
                                .opacity(loginModel.showOTPField ? 1 : 0)
                                .padding(.trailing, 15)
                        }
                    })
                    .padding(.top, 50)
                
                CustomTextField(hint: "OPT Code", text: $loginModel.otpCode)
                    .disabled(!loginModel.showOTPField)
                    .opacity(!loginModel.showOTPField ? 0.4 : 1)
                    .padding(.top, 20)
                
                Button(action: loginModel.showOTPField ? loginModel.verifyOTPCode : loginModel.getOPTCode) {
                    HStack(spacing: 15) {
                        Text(loginModel.showOTPField ? "Verify Code" : "Get Code")
                            .fontWeight(.semibold)
                            //.contentTransition(.identity)
                        
                        Image(systemName: "line.diagonal.arrow")
                            .font(.title3)
                            .rotationEffect(.init(degrees: 45))
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 25)
                    .padding(.vertical)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.black.opacity(0.05))
                    }
                }
                .padding(.top, 30)
                
                Text("(OR)")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 30)
                    .padding(.bottom, 20)
                    .padding(.leading, -60)
                    .padding(.horizontal)
                
                HStack(spacing: 8) {
                    // MARK: Custom Apple Sign in button
                    customButton()
                    .overlay {
                        SignInWithAppleButton { (request) in
                            loginModel.nonce = randomNonceString()
                            request.requestedScopes = [.email, .fullName]
                            request.nonce = sha256(loginModel.nonce)

                        } onCompletion: { (result) in
                            switch result {
                            case .success(let user):
                                print("success")
                                guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                                    print("error with firebase")
                                    return
                                }
                                loginModel.appleAuthenticate(credential: credential)
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        .signInWithAppleButtonStyle(.white)
                        .frame(height: 55)
                        .blendMode(.overlay)
                    }
                    .clipped()
                    
                    // MARK: Custom Google Sign in button
                    customButton(isGoogle: true)
                    .overlay {
                        // MARK: We have native google sign in button
                        // It's simple to integrate now
                        if let clientID = FirebaseApp.app()?.options.clientID {
                            GoogleSignInButton {
                                GIDSignIn.sharedInstance.signIn(with: .init(clientID: clientID), presenting: UIApplication.shared.rootController()) { user, error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                        return
                                    }
                                    // MARK: Logging Google User into Firebase
                                    if let user = user  {
                                        loginModel.logGoogleUser(user: user)
                                    }
                                }
                            }
                            .blendMode(.overlay)
                        }
                    }
                    .clipped()
                }
                .padding(.leading, -60)
                .frame(maxWidth: .infinity)
            }
            .padding(.leading, 60)
            .padding(.vertical, 15)
        }
        .alert(loginModel.errorMessage, isPresented: $loginModel.showError) {
            
        }
    }
    
    @ViewBuilder
    func customButton(isGoogle: Bool = false) -> some View {
        HStack {
            Group {
                if isGoogle {
                    Image("Google")
                        .resizable()
                        .renderingMode(.template)
                }
                else {
                    Image(systemName: "applelogo")
                        .resizable()
                }
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            .frame(height: 45)
            
            Text("\(isGoogle ? "Google" : "Apple") Sign in")
                .font(.callout)
                .lineLimit(1)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 15)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.black)
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
