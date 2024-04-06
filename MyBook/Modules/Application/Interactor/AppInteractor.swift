import Foundation
import GoogleSignIn

class AppInteractor: AppInteractorProtocol {
    
    var action: ((AppInteractorExternalEvent) -> Void)?
    
    private let userLogin: AppUserLoginProtocol
    
    init(userLogin: AppUserLoginProtocol) {
        self.userLogin = userLogin
        setupObservers()
    }
    
    private func setupObservers() {
        userLogin.action = { [weak self] in
            guard let user = $0 else {
                print("User didn't log in")
                self?.action?(.authorization(.unavaliable))
                return
            }
            
            print("User logged in")
            self?.action?(.authorization(.avaliable(user)))
        }
    }
    
    func sendEvent() {
        userLogin.sendEvent()
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
