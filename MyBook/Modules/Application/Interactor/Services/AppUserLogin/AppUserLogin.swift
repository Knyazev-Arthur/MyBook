import Foundation
import GoogleSignIn

class AppUserLogin: AppUserLoginProtocol {
    
    var action: ((AppInteractorUserStatus) -> Void)?
    var completeAction: (() -> Void)?
    
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
                getUserToken(user) { [weak self] result in
                    self?.resultGetToken(result)
                }
            
            case .authorization:
                googleService.restorePreviousSignIn { [weak self] user, error in
                    self?.sessiosVerification(user, error)
                }
        }
    }
    
    func resultGetToken(_ result: ResultGetToken) {
        switch result {
            case .succes(let message):
                print(message)
                completeAction?()
            
            case .failure(let error):
                print(error)
            }
    }
    
    func sessiosVerification(_ user: GIDGoogleUser?, _ error: Error?) {
        if let error {
            print("Error user login with Google: \(error.localizedDescription)")
            action?(.unavaliable)
            return
        }
        
        getUserToken(user) { [weak self] result in
            switch result {
                case .succes(_):
                    self?.action?(.avaliable)
                
                case .failure(let error):
                    self?.action?(.unavaliable)
                    print(error)
                }
        }
    }
    
    func getUserToken(_ user: GIDGoogleUser?, completion: @escaping (ResultGetToken) -> Void) {
        user?.refreshTokensIfNeeded { user, error in
            if let error {
                let error = "Error getting user token: \(error.localizedDescription)"
                completion(.failure(error))
                return
            }
            
            guard let user else {
                let error = "Error getting user inforamtion"
                completion(.failure(error))
                return
            }
            
            guard let token = user.idToken?.tokenString, !token.isEmpty else {
                let error = "Error getting user token"
                completion(.failure(error))
                return
            }
            
            guard let userID = user.userID, !userID.isEmpty else {
                let error = "Error getting user identifier"
                completion(.failure(error))
                return
            }
            let message = "User succefully logged in with token: \(token), id: \(userID)"
            completion(.succes(message))
        }
    }

}

// MARK: - AppUserLoginInternalEvent
enum AppUserLoginInternalEvent {
    case userLogin(_ user: GIDGoogleUser?)
    case authorization
}

// MARK: - ResultGetToken
enum ResultGetToken {
    case succes(String)
    case failure(String)
}
