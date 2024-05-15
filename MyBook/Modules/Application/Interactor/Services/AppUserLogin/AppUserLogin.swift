import Foundation
import GoogleSignIn

class AppUserLogin: AppUserLoginProtocol {
    
    let externalEvent: AnyPublisher<Result<String, Error>>
    let internalEvent: DataPublisher<AppUserLoginInternalEvent>
    
    private let dataPublisher: DataPublisher<Result<String, Error>>
    private let googleService: GIDSignIn
    
    init(googleService: GIDSignIn) {
        self.googleService = googleService
        self.dataPublisher = DataPublisher()
        self.externalEvent = AnyPublisher(dataPublisher)
        self.internalEvent = DataPublisher()
        setupObservers()
    }
    
}

// MARK: Private
private extension AppUserLogin {
    
    func setupObservers() {
        internalEvent.sink { [weak self] in
            self?.internalEventHandler($0)
        }
    }
    
    func internalEventHandler(_ event: AppUserLoginInternalEvent) {
        switch event {
            case .userLogin(let user):
                getUserToken(user)
            
            case .restorePreviousSignIn:
                googleService.restorePreviousSignIn { [weak self] user, error in
                    self?.checkDataAuthorization(user, error)
                }
        }
    }
    
    func checkDataAuthorization(_ user: GIDGoogleUser?, _ error: Error?) {
        if let error {
            dataPublisher.send(.failure(error))
            print("Error user login with Google: \(error.localizedDescription)")
            return
        }
        
        getUserToken(user)
    }
    
    func getUserToken(_ user: GIDGoogleUser?) {
        user?.refreshTokensIfNeeded { [weak self] user, error in
            if let error {
                self?.dataPublisher.send(.failure(error))
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
            self?.dataPublisher.send(.success(message))
        }
    }

}

// MARK: - AppUserLoginInternalEvent
enum AppUserLoginInternalEvent {
    case userLogin(_ user: GIDGoogleUser?)
    case restorePreviousSignIn
}

// MARK: - UserLoginStatus
enum AppUserLoginStatus {
    case unavaliable
    case avaliable
}
