import UIKit

class SplashRouter: SplashRouterProtocol {
    
    let externalEvent: AnyPublisher<Void>
    let internalEvent: DataPublisher<SplashRouterInternalEvent>
    
    private weak var viewController: UIViewController?
    private let dataPublisher: DataPublisher<Void>
    private let builder: SplashBuilderRoutProtocol
    
    init(builder: SplashBuilderRoutProtocol) {
        internalEvent = DataPublisher()
        dataPublisher = DataPublisher()
        externalEvent = AnyPublisher(dataPublisher)
        self.builder = builder
        setupObservers()
    }
    
}

// MARK: Private
private extension SplashRouter {
    
    func setupObservers() {
        internalEvent.sink { [weak self] event in
            self?.internalEventHandler(event)
        }
    }
    
    func internalEventHandler(_ event: SplashRouterInternalEvent?) {
        switch event {
            case .inject(let viewController):
                self.viewController = viewController
            
            case .start:
                builder.window?.rootViewController = viewController
            
            case .action:
                dataPublisher.send((nil))
            
            case .none:
                break
        }
    }
    
}

// MARK: - SplashRouterInternalEvent
enum SplashRouterInternalEvent {
    case inject(viewController: UIViewController?)
    case start
    case action
}
