import Foundation
import GoogleSignIn

class AppUserLogin: AppUserLoginProtocol {
    
    let externalEvent: AnyPublisher<Result<String, Error>>
    let internalEvent: DataPublisher<AppUserLoginInternalEvent>
    
    private let dataPublisher: DataPublisher<Result<String, Error>>
    private let googleService: GIDSignIn
    
    init(googleService: GIDSignIn) {
        dataPublisher = DataPublisher<Result<String, Error>>()
        externalEvent = AnyPublisher(dataPublisher)
        internalEvent = DataPublisher<AppUserLoginInternalEvent>()
        self.googleService = googleService
        setupObservers()
    }
    
}

// MARK: Private
private extension AppUserLogin {
    
    func setupObservers() {
        internalEvent.sink { [weak self] event in
            self?.internalEventHandler(event)
        }
    }
    
    func internalEventHandler(_ event: AppUserLoginInternalEvent?) {
        switch event {
            case .userLogin(let user):
                getUserToken(user)
            
            case .restorePreviousSignIn:
                googleService.restorePreviousSignIn { [weak self] user, error in
                    self?.checkDataPreviousAuthorization(user, error)
                }
            
            case .none:
                break
        }
    }
    
    func checkDataPreviousAuthorization(_ user: GIDGoogleUser?, _ error: Error?) {
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
