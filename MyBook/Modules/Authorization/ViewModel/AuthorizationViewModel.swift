import Foundation
import GoogleSignIn
 
class AuthorizationViewModel: AuthorizationViewModelProtocol {
    
    var action: ((AuthorizationViewInternalEvent) -> Void)?
    
    private weak var router: AuthorizationRouterProtocol?
    private let userLogin: AppUserLoginProtocol
    
    init(router: AuthorizationRouterProtocol?, userLogin: AppUserLoginProtocol) {
        self.router = router
        self.userLogin = userLogin
        setupObservers()
    }
    
    func sendEvent(_ event: AuthorizationViewModelInternalEvent) {
        internalEventHadler(event)
    }
    
}

// MARK: Private
private extension AuthorizationViewModel {
    
    func setupObservers() {
        router?.action = { [weak self] result, error in
            self?.userLogin.sendEvent(.userLogin(result, error))
        }
        
        userLogin.action = { [weak self] event in
            self?.externalEventHandler(event)
        }
    }
    
    func internalEventHadler(_ event: AuthorizationViewModelInternalEvent) {
        switch event {
            case .initialSetup:
                initialSetup()

            case .router:
                router?.sendEvent(.logInToGoogle)
        }
    }
    
    func externalEventHandler(_ event: AppUserLoginExternalEvent) {
        switch event {
            case .message(let message):
                action?(.message(message))
            
            case .authorization(_):
                break
        }
    }
    
    func initialSetup() {
        let imageLogo = UIImage(named: "Logo")
        let imageLoginButton = UIImage(named: "LoginButton")
        let text = NSLocalizedString("InitialGreeting", comment: "")
        action?(.viewData(imageLogo, imageLoginButton, text))
    }
}

// MARK: - AuthorizationViewModelInternalEvent
enum AuthorizationViewModelInternalEvent {
    case initialSetup
    case router
}
