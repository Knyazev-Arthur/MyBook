import Foundation
import GoogleSignIn

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
    
    private func externalEventHadler(_ event: AppUserLoginExternalEvent) {
        switch event {
            case .message(_):
                break
            
            case .authorization(let user):
                guard let user else {
                    print("User didn't log in")
                    action?(.authorization(.unavaliable))
                    return
                }
                print("User logged in")
                action?(.authorization(.avaliable(user)))
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
    case avaliable(GIDGoogleUser?)
}
