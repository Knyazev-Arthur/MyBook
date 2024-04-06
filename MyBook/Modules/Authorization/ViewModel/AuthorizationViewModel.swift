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
    
    private func setupObservers() {
        userLogin.action = { [weak self] in
            self?.action?($0)
        }
    }
    
    func sendEvent() {
        userLogin.sendEvent()
    }
    
}
