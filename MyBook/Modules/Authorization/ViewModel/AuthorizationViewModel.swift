import Foundation

class AuthorizationViewModel: AuthorizationViewModelProtocol {
    
    var action: ((String) -> Void)?
    
    private let userLogin: AuthorizationUserLoginProtocol
    
    init(userLogin: AuthorizationUserLoginProtocol) {
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
