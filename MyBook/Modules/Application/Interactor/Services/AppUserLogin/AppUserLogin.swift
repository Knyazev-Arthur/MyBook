import Foundation
import GoogleSignIn

class AppUserLogin: AppUserLoginProtocol {
    
    var action: ((Result<String, Error>) -> Void)?
    
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
            case .userLogin(let user):
                getUserToken(user)
            
            case .authorization:
                googleService.restorePreviousSignIn { [weak self] user, error in
                    self?.sessiosVerification(user, error)
                }
        }
    }
    
    func sessiosVerification(_ user: GIDGoogleUser?, _ error: Error?) {
        if let error {
            action?(.failure(error))
            print("Error user login with Google: \(error.localizedDescription)")
            return
        }
        
        getUserToken(user)
    }
    
    func getUserToken(_ user: GIDGoogleUser?) {
        user?.refreshTokensIfNeeded { [weak self] user, error in
            if let error {
                self?.action?(.failure(error))
                print("Error getting user token: \(error.localizedDescription)")
                return
            }
            
            guard let user else {
                print("Error getting user inforamtion")
                return
            }
            
            guard let token = user.idToken?.tokenString, !token.isEmpty else {
                print("Error getting user token")
                return
            }
            
            guard let userID = user.userID, !userID.isEmpty else {
                print("Error getting user identifier")
                return
            }
            
            print("User logged in")
            let message = "User succefully logged in with token: \(token), id: \(userID)"
            self?.action?(.success(message))
        }
    }

}

// MARK: - AppUserLoginInternalEvent
enum AppUserLoginInternalEvent {
    case userLogin(_ user: GIDGoogleUser?)
    case authorization
}
