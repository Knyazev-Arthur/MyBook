import GoogleSignIn
import UIKit
import Combine

class AuthorizationRouter: AuthorizationRouterProtocol {
        
    let internalEventPublisher: PassthroughSubject<AuthorizationRouterInternalEvent, Never>
    let externalEventPublisher: AnyPublisher<AuthorizationRouterExternalEvent, Never>
    
    private weak var viewController: UIViewController?
    private let externalDataPublisher: PassthroughSubject<AuthorizationRouterExternalEvent, Never>
    private let builder: AuthorizationBuilderRoutProtocol
    private var subscriptions: Set<AnyCancellable>
    
    init(builder: AuthorizationBuilderRoutProtocol) {
        self.builder = builder
        self.internalEventPublisher = PassthroughSubject<AuthorizationRouterInternalEvent, Never>()
        self.externalDataPublisher = PassthroughSubject<AuthorizationRouterExternalEvent, Never>()
        self.externalEventPublisher = AnyPublisher(externalDataPublisher)
        self.subscriptions = Set<AnyCancellable>()
        setupObservers()
    }
    
}

// MARK: Private
private extension AuthorizationRouter {
    
    func setupObservers() {
        internalEventPublisher.sink { [weak self] in
            self?.internalEventHandler($0)
        }.store(in: &subscriptions)
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
