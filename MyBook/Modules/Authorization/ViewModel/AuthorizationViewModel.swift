import Foundation

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
        userLogin.sendEvent()
    }
    
    private func setupObservers() {
        userLogin.action = { [weak self] in
            self?.action?($0)
        }
    }
    
}
