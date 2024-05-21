import UIKit
import GoogleSignIn
import Combine

class AuthorizationViewModel: AuthorizationViewModelProtocol {
    
    private weak var router: AuthorizationRouterProtocol?

    let internalEventPublisher: PassthroughSubject<AuthorizationViewModelInternalEvent, Never>
    let externalEventPublisher: AnyPublisher<AuthorizationViewData, Never>
        
    private let externalDataPublisher: PassthroughSubject<AuthorizationViewData, Never>
    private let userLogin: AppUserLoginProtocol
    private var subscriptions: Set<AnyCancellable>
    
    init(userLogin: AppUserLoginProtocol, router: AuthorizationRouterProtocol?) {
        self.userLogin = userLogin
        self.router = router
        self.internalEventPublisher = PassthroughSubject<AuthorizationViewModelInternalEvent, Never>()
        self.externalDataPublisher = PassthroughSubject<AuthorizationViewData, Never>()
        self.externalEventPublisher = AnyPublisher(externalDataPublisher)
        self.subscriptions = Set<AnyCancellable>()
        setupObservers()
    }

}

// MARK: Private
private extension AuthorizationViewModel {
    
    func setupObservers() {
        internalEventPublisher.sink { [weak self] in
            self?.internalEventHandler($0)
        }.store(in: &subscriptions)
        
        router?.externalEventPublisher.sink { [weak self] in
            self?.routerEventHandler($0)
        }.store(in: &subscriptions)
        
        userLogin.externalEventPublisher.sink { [weak self] in
            self?.userAuthorizationHandler($0)
        }.store(in: &subscriptions)
    }
    
    func internalEventHandler(_ event: AuthorizationViewModelInternalEvent) {
        switch event {
            case .initialSetup:
                initialSetup()

            case .logInToGoogle:
                router?.internalEventPublisher.send(.logInToGoogle)
        }
    }
    
    func initialSetup() {
        let imageLogo = UIImage(named: "Logo")
        let imageLoginButton = UIImage(named: "LoginButton")
        let text = NSLocalizedString("InitialGreeting", comment: "")
        let authorizationViewData = AuthorizationViewData(imageLogo: imageLogo, imageLoginButton: imageLoginButton, textLabelGreeting: text)
        externalDataPublisher.send(authorizationViewData)
    }
    
    func routerEventHandler(_ event: AuthorizationRouterExternalEvent) {
        switch event {
            case .failure(let error):
                print("Error user login with Google: \(error.localizedDescription)")
            
            case .success(let user):
                authorization(user)
            
            case .complete:
                break
        }
    }
    
    func authorization(_ user: GIDGoogleUser?) {
        guard let user else {
            print("User login result has an empty value")
            return
        }
        
        userLogin.internalEventPublisher.send(.userLogin(user))
    }
    
    func userAuthorizationHandler(_ event: Result<String, Error>) {
        switch event {
            case .success(let message):
                print(message)
                router?.internalEventPublisher.send(.complete)
            
            case .failure(_):
                break
        }
    }
    
}

// MARK: - AuthorizationViewModelInternalEvent
enum AuthorizationViewModelInternalEvent {
    case initialSetup
    case logInToGoogle
}
