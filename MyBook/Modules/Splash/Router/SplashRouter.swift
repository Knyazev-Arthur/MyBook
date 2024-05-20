import UIKit
import Combine

class SplashRouter: SplashRouterProtocol {
    
    let internalEventPublisher: PassthroughSubject<SplashRouterInternalEvent, Never>
    let externalEventPublisher: AnyPublisher<Void, Never>
    
    private let externalDataPublisher: PassthroughSubject<Void, Never>
    private let builder: SplashBuilderRoutProtocol
    private var subscriptions: Set<AnyCancellable>
    private weak var viewController: UIViewController?
    
    init(builder: SplashBuilderRoutProtocol) {
        self.builder = builder
        self.internalEventPublisher = PassthroughSubject<SplashRouterInternalEvent, Never>()
        self.externalDataPublisher = PassthroughSubject<Void, Never>()
        self.externalEventPublisher = AnyPublisher(externalDataPublisher)
        self.subscriptions = Set<AnyCancellable>()
        setupObservers()
    }
    
}

// MARK: Private
private extension SplashRouter {
    
    func setupObservers() {
        internalEventPublisher.sink { [weak self] in
            self?.internalEventHandler($0)
        }.store(in: &subscriptions)
    }
    
    func internalEventHandler(_ event: SplashRouterInternalEvent) {
        switch event {
            case .inject(let value):
                guard viewController == nil else { return }
                viewController = value
            
            case .start:
                builder.window?.rootViewController = viewController
            
            case .action:
                externalDataPublisher.send()
        }
    }
    
}

// MARK: - SplashRouterInternalEvent
enum SplashRouterInternalEvent {
    case inject(viewController: UIViewController?)
    case start
    case action
}
