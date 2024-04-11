import Foundation
import GoogleSignIn

class AuthorizationViewModel: AuthorizationViewModelProtocol {
    
    var action: ((String) -> Void)?
    
    private weak var router: AuthorizationRouterProtocol?
    private let userLogin: AuthorizationUserLoginProtocol
    
    init(router: AuthorizationRouterProtocol?, userLogin: AuthorizationUserLoginProtocol) {
        self.router = router
        self.userLogin = userLogin
        setupObservers()
    }
    
    func sendEvent() {
        router?.sendEvent(.logInToGoogle)
    }
    
}

// MARK: Private
private extension AuthorizationViewModel {
    
    func setupObservers() {
        
        router?.action = { [weak self] result, error in
            self?.userLogin.sendEvent(result, error)
        }
        
        userLogin.action = { [weak self] in
            self?.action?($0)
        }
        
    }
    
}
