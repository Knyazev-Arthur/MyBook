import Foundation
import UIKit
import GoogleSignIn

class AuthorizationViewModel: AuthorizationViewModelProtocol {
    
    let externalEvent: AnyPublisher<AuthorizationViewData>
    let internalEvent: DataPublisher<AuthorizationViewModelInternalEvent>
    
    private let dataPublisher: DataPublisher<AuthorizationViewData>
    private let userLogin: AppUserLoginProtocol
    private weak var router: AuthorizationRouterProtocol?
    
    init(userLogin: AppUserLoginProtocol, router: AuthorizationRouterProtocol?) {
        dataPublisher = DataPublisher<AuthorizationViewData>()
        externalEvent = AnyPublisher(dataPublisher)
        internalEvent = DataPublisher<AuthorizationViewModelInternalEvent>()
        self.userLogin = userLogin
        self.router = router
        setupObservers()
        setupEventHandlers()
    }

}

// MARK: Private
private extension AuthorizationViewModel {
    
    func setupObservers() {
        internalEvent.sink { [weak self] event in
            self?.internalEventHandler(event)
        }
    }
    
    func setupEventHandlers() {
        router?.externalEvent.sink({ [weak self] in
            self?.externalEventHandler($0)
        })
        
        userLogin.externalEvent.sink { [weak self] event in
            self?.userAuthorizationHandler(event)
        }
    }
    
    func userAuthorizationHandler(_ event: Result<String, Error>?) {
        switch event {
            case .success(let message):
                print(message)
                router?.internalEvent.send(.complete)
            
            default:
                break
        }
    }
    
    func internalEventHandler(_ event: AuthorizationViewModelInternalEvent?) {
        switch event {
            case .initialSetup:
                initialSetup()

            case .router:
                router?.internalEvent.send(.logInToGoogle)
            
            case .none:
                break
        }
    }
    
    func externalEventHandler(_ event: AuthorizationRouterExternalEvent?) {
        switch event {
            case .failure(let error):
                print("Error user login with Google: \(error.localizedDescription)")
            
            case .success(let user):
                authorization(user)
            
            default:
                break
        }
    }
    
    func initialSetup() {
        let imageLogo = UIImage(named: "Logo")
        let imageLoginButton = UIImage(named: "LoginButton")
        let text = NSLocalizedString("InitialGreeting", comment: "")
        let authorizationViewData = AuthorizationViewData(imageLogo: imageLogo, imageLoginButton: imageLoginButton, textLabelGreeting: text)
        dataPublisher.send(authorizationViewData)
    }
    
    func authorization(_ user: GIDGoogleUser?) {
        guard let user else {
            print("User login result has an empty value")
            return
        }
        
        userLogin.internalEvent.send(.userLogin(user))
    }
    
}

// MARK: - AuthorizationViewModelInternalEvent
enum AuthorizationViewModelInternalEvent {
    case initialSetup
    case router
}
