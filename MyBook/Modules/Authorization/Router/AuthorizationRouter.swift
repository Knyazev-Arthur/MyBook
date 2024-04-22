import Foundation
import GoogleSignIn
import UIKit

class AuthorizationRouter: AuthorizationRouterProtocol {
    
    var action: ((AuthorizationRouterExternalEvent) -> Void)?
    
    private weak var viewController: UIViewController?
    private weak var window: UIWindow?
    private let builder: AuthorizationBuilderVCProtocol
    
    init(window: UIWindow?, builder: AuthorizationBuilderVCProtocol) {
        self.window = window
        self.builder = builder
    }
    
    func sendEvent(_ event: AuthorizationRouterInternalEvent) {
        internalEventHadler(event)
    }
    
}

// MARK: Private
private extension AuthorizationRouter {
    
    func internalEventHadler(_ event: AuthorizationRouterInternalEvent) {
        switch event {
            case .inject(let viewController):
                self.viewController = viewController
            
            case .start:
                setRootVC()
            
            case .logInToGoogle:
                startGoogleSignIn()
            
            case .blankScreen:
                setRootBlankVC()
        }
    }
    
    func setRootVC() {
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 0.4
        window?.layer.add(transition, forKey: "transition")
        window?.rootViewController = viewController
    }
    
    func setRootBlankVC() {
        let blankScreen = builder.blankSreen
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 0.4
        window?.layer.add(transition, forKey: "transition")
        window?.rootViewController = blankScreen
    }
    
    func startGoogleSignIn() {
        guard let viewController else { return }
        builder.googleService?.signIn(withPresenting: viewController) { [weak self] result, error in
            guard error == nil else {
                self?.action?(.failure(error))
                return
            }
            
            self?.action?(.success(result))
        }
    }
    
}

// MARK: - AuthorizationRouterInternalEvent
enum AuthorizationRouterInternalEvent {
    case inject(viewController: UIViewController?)
    case start
    case logInToGoogle
    case blankScreen
}

// MARK: - AuthorizationRouterInternalEvent
enum AuthorizationRouterExternalEvent {
    case success(_ result: GIDSignInResult?)
    case failure(_ error: Error?)
}
