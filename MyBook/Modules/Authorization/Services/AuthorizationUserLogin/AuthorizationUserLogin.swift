import Foundation
import GoogleSignIn

class AuthorizationUserLogin: AuthorizationUserLoginProtocol {
    
    var action: ((String) -> Void)?
    
    private let googleService: GIDSignIn
    
    init(googleService: GIDSignIn) {
        self.googleService = googleService
    }
    
    func sendEvent(_ result: GIDSignInResult?, _ error: Error?) {
        startUserLogin(result, error)
    }
    
}

// MARK: Private
private extension AuthorizationUserLogin {
    
    func startUserLogin(_ result: GIDSignInResult?, _ error: Error?) {
        guard error == nil else {
            let error = "Error user login with Google: \(error!.localizedDescription)"
            action?(error)
            return
        }
        
        guard let result else {
            let error = "User login result has an empty value"
            action?(error)
            return
        }
        
        getUserToken(result)
        
    }
    
    func getUserToken(_ result: GIDSignInResult) {
        result.user.refreshTokensIfNeeded { [weak self] user, error in
            guard error == nil else {
                let error = "Error getting user token: \(error!)"
                self?.action?(error)
                return
            }
            
            guard let user else {
                let error = "Error getting user inforamtion"
                self?.action?(error)
                return
            }
            
            guard let token = user.idToken?.tokenString else {
                let error = "Error getting user token"
                self?.action?(error)
                return
            }
            
            guard let userID = user.userID else {
                let error = "Error getting user identifier"
                self?.action?(error)
                return
            }
            
            let message = "User succefully logged in with token: \(token), id: \(userID)"
            self?.action?(message)
        }
        
    }
    
}
