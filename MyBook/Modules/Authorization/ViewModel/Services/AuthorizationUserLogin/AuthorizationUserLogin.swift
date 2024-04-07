import Foundation
import GoogleSignIn

class AuthorizationUserLogin: AuthorizationUserLoginProtocol {
    
    var action: ((String) -> Void)?
    weak var viewController: UIViewController?
    
    private let googleService: GIDSignIn
    
    init(googleService: GIDSignIn) {
        self.googleService = googleService
    }
    
    func sendEvent() {
        startUserLogin()
    }
    
}

// MARK: Private
private extension AuthorizationUserLogin {
    
    func startUserLogin() {
        guard let viewController else {
            let error = "Authorization service doesn't have a view controller"
            action?(error)
            return
        }
        
        googleService.signIn(withPresenting: viewController) { [weak self] result, error in
            guard error == nil else {
                let error = "Error user login with Google: \(error!.localizedDescription)"
                self?.action?(error)
                return
            }
            
            guard let result else {
                let error = "User login result has an empty value"
                self?.action?(error)
                return
            }
            
            self?.getUserToken(result)
        }
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
