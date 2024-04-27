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
    
    func externalEventHadler(_ event: AppInteractorUserStatus) {
        switch event {
            case .avaliable:
                action?(.authorization(.avaliable))
                print("User logged in")
                
            case .unavaliable:
                action?(.authorization(.unavaliable))
                print("User didn't log in")
            }
        
    }
    
}

// MARK: - AppInteractorExternalEvent
enum AppInteractorExternalEvent {
    case authorization(AppInteractorUserStatus)
    case pushNotitication([String : Any])
}

// MARK: - AppInteractorUserStatus
enum AppInteractorUserStatus {
    case unavaliable
    case avaliable
}
