import GoogleSignIn
import UIKit

class AuthorizationRouter: AuthorizationRouterProtocol {
    
    var action: ((Result<GIDGoogleUser?, Error>) -> Void)?
    var actionСomplete: (() -> Void)?
    
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
                RootController.setRootViewController(builder.window, viewController)
            
            case .logInToGoogle:
                startGoogleSignIn()
            
            case .complete:
                actionСomplete?()
        }
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
