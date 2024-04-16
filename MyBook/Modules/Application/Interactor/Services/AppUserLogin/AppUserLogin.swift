import Foundation
import GoogleSignIn

class AppUserLogin: AppUserLoginProtocol {
    
    var action: ((AppUserLoginExternalEvent) -> Void)?
    
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
    
    func startUserLogin(_ result: GIDSignInResult?, _ error: Error?) {
        guard error == nil else {
            let error = "Error user login with Google: \(error!.localizedDescription)"
            action?(.message(error))
            return
        }
        
        guard let result else {
            let error = "User login result has an empty value"
            action?(.message(error))
            return
        }
        
        getUserToken(result)
        
    }
    
    func getUserToken(_ result: GIDSignInResult) {
        result.user.refreshTokensIfNeeded { [weak self] user, error in
            guard error == nil else {
                let error = "Error getting user token: \(error!)"
                self?.action?(.message(error))
                return
            }
            
            guard let user else {
                let error = "Error getting user inforamtion"
                self?.action?(.message(error))
                return
            }
            
            guard let token = user.idToken?.tokenString else {
                let error = "Error getting user token"
                self?.action?(.message(error))
                return
            }
            
            guard let userID = user.userID else {
                let error = "Error getting user identifier"
                self?.action?(.message(error))
                return
            }
            
            let message = "User succefully logged in with token: \(token), id: \(userID)"
            self?.action?(.message(message))
        }
        
    }
    
    
    func internalEventHandler(_ event: AppUserLoginInternalEvent) {
        switch event {
            case .userLogin(let result, let error):
                startUserLogin(result, error)
                
            case .authorization:
                googleService.restorePreviousSignIn { [weak self] user, _ in
                    self?.action?(.authorization(user))
                }
        }
    }
    
}

// MARK: - AppUserLoginExternalEvent
enum AppUserLoginExternalEvent {
    case message(String)
    case authorization(GIDGoogleUser?)
}

// MARK: - AppUserLoginInternalEvent
enum AppUserLoginInternalEvent {
    case userLogin(_ result: GIDSignInResult?, _ error: Error?)
    case authorization
}
