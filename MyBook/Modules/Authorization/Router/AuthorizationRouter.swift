import GoogleSignIn
import UIKit

class AuthorizationRouter: AuthorizationRouterProtocol {
    
    var action: ((AuthorizationRouterExternalEvent) -> Void)? {
        willSet {
            subscriptions.append(newValue)
        }
    }
    
    private weak var viewController: UIViewController?
    private var subscriptions: Array<((AuthorizationRouterExternalEvent) -> Void)?>
    private let builder: AuthorizationBuilderRoutProtocol
    
    init(builder: AuthorizationBuilderRoutProtocol) {
        self.builder = builder
        self.subscriptions = Array<((AuthorizationRouterExternalEvent) -> Void)?>()
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
                sendExternalEvent(.complete)
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
                self?.sendExternalEvent(.failure(error))
                return
            }
            
            self?.sendExternalEvent(.success(result?.user))
        }
    }
    
    func sendExternalEvent(_ event: AuthorizationRouterExternalEvent) {
        subscriptions.forEach {
            $0?(event)
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

// MARK: - AuthorizationRouterExternalEvent
enum AuthorizationRouterExternalEvent {
    case failure(Error)
    case success(GIDGoogleUser?)
    case complete
}
