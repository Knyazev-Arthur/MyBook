import Foundation
import GoogleSignIn
import Combine

class AppUserLogin: AppUserLoginProtocol {
    
    let internalEventPublisher: PassthroughSubject<AppUserLoginInternalEvent, Never>
    let externalEventPublisher: AnyPublisher<String, Error>
    
    private let externalDataPublisher: PassthroughSubject<String, Error>
    private let googleService: GIDSignIn
    private var subscriptions: Set<AnyCancellable>
    
    init(googleService: GIDSignIn) {
        self.googleService = googleService
        self.internalEventPublisher = PassthroughSubject<AppUserLoginInternalEvent, Never>()
        self.externalDataPublisher = PassthroughSubject<String, Error>()
        self.externalEventPublisher = AnyPublisher(externalDataPublisher)
        self.subscriptions = Set<AnyCancellable>()
        setupObservers()
    }
    
}

// MARK: Private
private extension AppUserLogin {
    
    func setupObservers() {
        internalEventPublisher.sink { [weak self] in
            self?.internalEventHandler($0)
        }.store(in: &subscriptions)
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
            externalDataPublisher.send(.failure(error))
            print("Error user login with Google: \(error.localizedDescription)")
            return
        }
        
        getUserToken(user)
    }
    
    func getUserToken(_ user: GIDGoogleUser?) {
        user?.refreshTokensIfNeeded { [weak self] user, error in
            if let error {
                self?.externalDataPublisher.send(.failure(error))
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
            self?.externalDataPublisher.send(.success(message))
        }
    }

}

// MARK: - AppUserLoginInternalEvent
enum AppUserLoginInternalEvent {
    case userLogin(_ user: GIDGoogleUser?)
    case restorePreviousSignIn
}

// MARK: - AppUserLoginStatus
enum AppUserLoginStatus {
    case unavaliable
    case avaliable
}
