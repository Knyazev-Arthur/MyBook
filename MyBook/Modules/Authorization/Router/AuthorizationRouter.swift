import GoogleSignIn
import UIKit

class AuthorizationRouter: AuthorizationRouterProtocol {
    
    let externalEvent: AnyPublisher<AuthorizationRouterExternalEvent>
    let internalEvent: DataPublisher<AuthorizationRouterInternalEvent>
    
    private weak var viewController: UIViewController?
    private let externalDataPublisher: DataPublisher<AuthorizationRouterExternalEvent>
    private let builder: AuthorizationBuilderRoutProtocol
    
    init(builder: AuthorizationBuilderRoutProtocol) {
        self.builder = builder
        self.externalDataPublisher = DataPublisher()
        self.externalEvent = AnyPublisher(externalDataPublisher)
        self.internalEvent = DataPublisher()
        setupObservers()
    }
    
}

// MARK: Private
private extension AuthorizationRouter {
    
    func setupObservers() {
        internalEvent.sink { [weak self] in
            self?.internalEventHandler($0)
        }
    }
    
    func internalEventHandler(_ event: AuthorizationRouterInternalEvent) {
        switch event {
            case .inject(let value):
                guard viewController == nil else { return }
                viewController = value
            
            case .start:
                setRootVC()
            
            case .logInToGoogle:
                startGoogleSignIn()
            
            case .complete:
                externalDataPublisher.send(.complete)
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
                self?.externalDataPublisher.send(.failure(error))
                return
            }
            
            self?.externalDataPublisher.send(.success(result?.user))
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
