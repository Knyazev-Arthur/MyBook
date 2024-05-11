import Foundation
import UIKit
import GoogleSignIn

class AuthorizationViewModel: AuthorizationViewModelProtocol {
    
    var action: ((AuthorizationViewData) -> Void)?
    
    private weak var router: AuthorizationRouterProtocol?
    private let userLogin: AppUserLoginProtocol
    
    init(router: AuthorizationRouterProtocol?, userLogin: AppUserLoginProtocol) {
        self.router = router
        self.userLogin = userLogin
        setupObservers()
    }
    
    func sendEvent(_ event: AuthorizationViewModelInternalEvent) {
        handleRouterEvent(event)
    }

}

// MARK: Private
private extension AuthorizationViewModel {
    
    func setupObservers() {
        router?.action?.addSubscription({ [weak self] in
            self?.externalEventHadler($0)
        })
        
        userLogin.action = { [weak self] event in
            self?.userAuthorizationHandler(event)
        }
    }
    
    func userAuthorizationHandler(_ event: Result<String, Error>) {
        switch event {
            case .success(let message):
                print(message)
                router?.sendEvent(.complete)
            
            default:
                break
        }
    }
    
    func handleRouterEvent(_ event: AuthorizationViewModelInternalEvent) {
        switch event {
            case .initialSetup:
                initialSetup()

            case .router:
                router?.sendEvent(.logInToGoogle)
        }
    }
    
    func externalEventHadler(_ event: AuthorizationRouterExternalEvent?) {
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
        action?(authorizationViewData)
    }
    
    func authorization(_ user: GIDGoogleUser?) {
        guard let user else {
            print("User login result has an empty value")
            return
        }
        
        userLogin.sendEvent(.userLogin(user))
    }
    
}

// MARK: - AuthorizationViewModelInternalEvent
enum AuthorizationViewModelInternalEvent {
    case initialSetup
    case router
}
