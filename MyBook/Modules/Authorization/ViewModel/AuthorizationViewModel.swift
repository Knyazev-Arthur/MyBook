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
            case .logoImage:
                let image = UIImage(named: "Logo")
                action?(.logoImage(image))
            
            case .router:
                router?.sendEvent(.logInToGoogle)
        }
    }
    
}

// MARK: - AuthorizationViewModelInternalEvent
enum AuthorizationViewModelInternalEvent {
    case logoImage
    case router
}
