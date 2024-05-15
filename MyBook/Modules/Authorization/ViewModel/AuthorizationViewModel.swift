import Foundation
import UIKit
import GoogleSignIn

class AuthorizationViewModel: AuthorizationViewModelProtocol {
    
    let externalEvent: AnyPublisher<AuthorizationViewData>
    let internalEvent: DataPublisher<AuthorizationViewModelInternalEvent>
    
    private let externalDataPublisher: DataPublisher<AuthorizationViewData>
    private let userLogin: AppUserLoginProtocol
    private weak var router: AuthorizationRouterProtocol?
    
    init(userLogin: AppUserLoginProtocol, router: AuthorizationRouterProtocol?) {
        self.userLogin = userLogin
        self.router = router
        self.externalDataPublisher = DataPublisher()
        self.externalEvent = AnyPublisher(externalDataPublisher)
        self.internalEvent = DataPublisher()
        setupObservers()
    }

}

// MARK: Private
private extension AuthorizationViewModel {
    
    func setupObservers() {
        internalEvent.sink { [weak self] in
            self?.internalEventHandler($0)
        }
        
        router?.externalEvent.sink { [weak self] in
            self?.routerExternalEventHandler($0)
        }
        
        userLogin.externalEvent.sink { [weak self] in
            self?.userAuthorizationHandler($0)
        }
    }
    
    func internalEventHandler(_ event: AuthorizationViewModelInternalEvent) {
        switch event {
            case .initialSetup:
                initialSetup()

            case .router:
                router?.internalEvent.send(.logInToGoogle)
        }
    }
    
    func initialSetup() {
        let imageLogo = UIImage(named: "Logo")
        let imageLoginButton = UIImage(named: "LoginButton")
        let text = NSLocalizedString("InitialGreeting", comment: "")
        let authorizationViewData = AuthorizationViewData(imageLogo: imageLogo, imageLoginButton: imageLoginButton, textLabelGreeting: text)
        externalDataPublisher.send(authorizationViewData)
    }
    
    func routerExternalEventHandler(_ event: AuthorizationRouterExternalEvent) {
        switch event {
            case .failure(let error):
                print("Error user login with Google: \(error.localizedDescription)")
            
            case .success(let user):
                authorization(user)
            
            case .complete:
                break
        }
    }
    
    func authorization(_ user: GIDGoogleUser?) {
        guard let user else {
            print("User login result has an empty value")
            return
        }
        
        userLogin.internalEvent.send(.userLogin(user))
    }
    
    func userAuthorizationHandler(_ event: Result<String, Error>) {
        switch event {
            case .success(let message):
                print(message)
                router?.internalEvent.send(.complete)
            
            case .failure(_):
                break
        }
    }
    
}

// MARK: - AuthorizationViewModelInternalEvent
enum AuthorizationViewModelInternalEvent {
    case initialSetup
    case router
}
