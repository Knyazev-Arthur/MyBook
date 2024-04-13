import Foundation
import GoogleSignIn

class AuthorizationViewModel: AuthorizationViewModelProtocol {
    
    var action: ((AuthorizationViewInternalEvent) -> Void)?
    
    private weak var router: AuthorizationRouterProtocol?
    private let userLogin: AuthorizationUserLoginProtocol
    
    init(router: AuthorizationRouterProtocol?, userLogin: AuthorizationUserLoginProtocol) {
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
            self?.userLogin.sendEvent(result, error)
        }
        
        userLogin.action = { [weak self] in
            self?.action?(.message($0))
        }
        
    }
    
    func internalEventHadler(_ event: AuthorizationViewModelInternalEvent) {
        switch event {
            case .imageLogo:
                let image = UIImage(named: "Logo")
                action?(.imageLogo(image))
            
            case .router:
                router?.sendEvent(.logInToGoogle)
            
            case .imageLoginButton:
                let image = UIImage(named: "LoginButton")
                action?(.imageLoginButton(image))
            
            case .textLabelGreating:
                let text = NSLocalizedString("initialGreeting", comment: "")
                action?(.textLabelGreeting(text))
        }
    }
    
}

// MARK: - AuthorizationViewModelInternalEvent
enum AuthorizationViewModelInternalEvent {
    case imageLogo
    case router
    case imageLoginButton
    case textLabelGreating
}
