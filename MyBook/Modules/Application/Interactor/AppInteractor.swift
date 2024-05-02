import Foundation

class AppInteractor: AppInteractorProtocol {
    
    var action: ((AppInteractorExternalEvent) -> Void)?
    
    private let userLogin: AppUserLoginProtocol
    
    init(userLogin: AppUserLoginProtocol) {
        self.userLogin = userLogin
        setupObservers()
    }
    
    func sendEvent() {
        userLogin.sendEvent(.authorization)
    }

}

// MARK: Private
private extension AppInteractor {
    
    private func setupObservers() {
        userLogin.action = { [weak self] event in
            self?.externalEventHadler(event)
        }
    }
    
    func externalEventHadler(_ event: Result<String, Error>) {
        switch event {
            case .success(_):
                action?(.authorization(.avaliable))
                
            case .failure(_):
                action?(.authorization(.unavaliable))
        }
    }
    
}

// MARK: - AppInteractorExternalEvent
enum AppInteractorExternalEvent {
    case authorization(UserLoginEventHandler)
    case pushNotitication([String : Any])
}

// MARK: - AppInteractorUserStatus
enum UserLoginEventHandler {
    case unavaliable
    case avaliable
}
