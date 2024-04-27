import Foundation
import GoogleSignIn
import UIKit

class AuthorizationRouter: AuthorizationRouterProtocol {
    
    var action: ((Result<GIDGoogleUser?, Error>) -> Void)?
    var completeAction: (() -> Void)?
    
    private weak var viewController: UIViewController?
    private let builder: AuthorizationBuilderRoutProtocol
    
    init(builder: AuthorizationBuilderRoutProtocol) {
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
            
            case .complete:
                completeAction?()
        }
    }
    
    func setRootVC() {
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 0.4
        builder.window?.layer.add(transition, forKey: "transition")
        builder.window?.rootViewController = viewController
    }
    
    func startGoogleSignIn() {
        guard let viewController else { return }
        builder.googleService?.signIn(withPresenting: viewController) { [weak self] result, error in
            if let error {
                self?.action?(.failure(error))
                return
            }
            
            self?.action?(.success(result?.user))
        }
    }
    
}

// MARK: - AuthorizationRouterInternalEvent
enum AuthorizationRouterInternalEvent {
    case inject(viewController: UIViewController?)
    case start
    case logInToGoogle
    case complete
}
