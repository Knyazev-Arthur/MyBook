import Foundation
import GoogleSignIn
 
class AuthorizationViewModel: AuthorizationViewModelProtocol {
    
    var action: ((AuthorizationViewData) -> Void)?
    
    private weak var router: AuthorizationRouterProtocol?
    private let userLogin: AppUserLoginProtocol
    
    init(router: AuthorizationRouterProtocol?, userLogin: AppUserLoginProtocol) {
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
        router?.action = { [weak self] event in
            self?.internalEventHadler(event)
        }
    }
    
    func internalEventHadler(_ event: AuthorizationViewModelInternalEvent) {
        switch event {
            case .initialSetup:
                initialSetup()

            case .router:
                router?.sendEvent(.logInToGoogle)
        }
    }
    
    func internalEventHadler(_ event: AuthorizationRouterExternalEvent) {
        switch event {
            case .failure(let error):
                print("Error user login with Google: \(error!.localizedDescription)")
            
            case .success(let result):
                authorization(result)
        }
    }
    
    func initialSetup() {
        let imageLogo = UIImage(named: "Logo")
        let imageLoginButton = UIImage(named: "LoginButton")
        let text = NSLocalizedString("InitialGreeting", comment: "")
        let authorizationViewData = AuthorizationViewData(imageLogo: imageLogo, 
                                                          imageLoginButton: imageLoginButton,
                                                          textLabelGreeting: text)
        action?(authorizationViewData)
    }
    
    func authorization(_ result: GIDSignInResult?) {
        guard let result else {
            print("User login result has an empty value")
            return
        }
        
        userLogin.sendEvent(.userLogin(result))
        router?.sendEvent(.blankScreen)
    }
    
}

// MARK: - AuthorizationViewModelInternalEvent
enum AuthorizationViewModelInternalEvent {
    case initialSetup
    case router
}
