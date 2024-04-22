import Foundation
import GoogleSignIn

class AppUserLogin: AppUserLoginProtocol {
    
    var action: ((GIDGoogleUser?) -> Void)?
    
    private let googleService: GIDSignIn
    
    init(googleService: GIDSignIn) {
        self.googleService = googleService
    }
    
    func sendEvent(_ event: AppUserLoginInternalEvent) {
        internalEventHandler(event)
    }
    
}

// MARK: Private
private extension AppUserLogin {
    
    func internalEventHandler(_ event: AppUserLoginInternalEvent) {
        switch event {
            case .userLogin(let result):
                getUserToken(result)
                
            case .authorization:
                googleService.restorePreviousSignIn { [weak self] user, _ in
                    self?.action?(user)
                }
        }
    }
    
    func getUserToken(_ result: GIDSignInResult?) {
        result?.user.refreshTokensIfNeeded { user, error in
            guard error == nil else {
                let error = "Error getting user token: \(error!)"
                print(error)
                return
            }
            
            guard let user else {
                let error = "Error getting user inforamtion"
                print(error)
                return
            }
            
            guard let token = user.idToken?.tokenString else {
                let error = "Error getting user token"
                print(error)
                return
            }
            
            guard let userID = user.userID else {
                let error = "Error getting user identifier"
                print(error)
                return
            }
            
            let message = "User succefully logged in with token: \(token), id: \(userID)"
            print(message)
        }
        
    }
    
}

// MARK: - AppUserLoginInternalEvent
enum AppUserLoginInternalEvent {
    case userLogin(_ result: GIDSignInResult?)
    case authorization
}
