//
//  LoginViewModel.swift
//  Login
//
//  Created by Taeyoun Lee on 2022/08/29.
//

import SwiftUI
import Firebase
import CryptoKit
import AuthenticationServices
import GoogleSignIn

class LoginViewModel: ObservableObject {
    // MARK: View Properties
    @Published var mobileNo: String = ""
    @Published var otpCode: String = ""
    
    @Published var clientCode: String = ""
    @Published var showOTPField: Bool = false
    
    // MARK: Error Properties
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    // MARK: App Log Status
    @AppStorage("log_status") var logStatus: Bool = false
    
    // MARK: Apple Sign in Properties
    @Published var nonce: String = ""
    
    // MARK: Firebase API's
    func getOPTCode() {
        UIApplication.shared.closeKeyboard()
        Task {
            do {
                // MARK: Disable it when testing with Real Device
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                
                let code = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(mobileNo)", uiDelegate: nil)
                await MainActor.run(body: {
                    clientCode = code
                    // MARK: Enabling OTP Field When It's success
                    withAnimation(.easeInOut) {
                        showOTPField = true
                    }
                })
            } catch {
                await handleError(error: error)
            }
        }
    }
    
    func verifyOTPCode() {
        UIApplication.shared.closeKeyboard()
        Task {
            do {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: clientCode, verificationCode: otpCode)
                
                try await Auth.auth().signIn(with: credential)
                
                // MARK: User Logged in Successfully
                print("Success!!")
                await MainActor.run(body: {
                    withAnimation(.easeInOut) {
                        logStatus = true
                    }
                })
            } catch {
                await handleError(error: error)
            }
        }
    }
    
    // MARK: Handle Error
    func handleError(error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
    
    // MARK: Apple Sigh in API
    func appleAuthenticate(credential: ASAuthorizationAppleIDCredential) {
        
        // getting Token...
        guard let token = credential.identityToken else {
            print("error with firebase")
            return
        }
        
        // Token String...
        guard let tokenString = String(data: token, encoding: .utf8) else {
            print("error with Token")
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
        
        Auth.auth().signIn(with: firebaseCredential) { (result, err) in
            
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            // User Successfully Logged Into Firebase...
            print("Logged In Success")
            withAnimation(.easeInOut) {
                self.logStatus = true
            }
        }
    }
    
    // MARK: Logging Google User into Firebase
    func logGoogleUser(user: GIDGoogleUser) {
        Task {
            do {
                guard let idToken = user.authentication.idToken else { return }
                let accessToken = user.authentication.accessToken
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
                //OAuthProvider.credential(withProviderID: idToken, accessToken: accessToken)
                try await Auth.auth().signIn(with: credential)
                print("Success Google!")
                await MainActor.run(body: {
                    withAnimation(.easeInOut) {
                        logStatus = true
                    }
                })
            } catch {
                await handleError(error: error)
            }
        }
    }
}

// MARK: Extension
extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // Root COntroller
    func rootController() -> UIViewController {
        guard let window = connectedScenes.first as? UIWindowScene else { return .init() }
        guard let viewcontroller = window.windows.last?.rootViewController else { return .init() }
        
        return viewcontroller
    }
}

// MARK: Apple Sign in Helpers
func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
    }.joined()
    
    return hashString
}

func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
            }
            return random
        }
        
        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }
            
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    
    return result
}
