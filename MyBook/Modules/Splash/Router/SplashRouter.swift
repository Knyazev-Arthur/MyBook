import UIKit

class SplashRouter: SplashRouterProtocol {
    
    let externalEvent: AnyPublisher<Void?>
    let internalEvent: DataPublisher<SplashRouterInternalEvent>
    
    private weak var viewController: UIViewController?
    private let externalDataPublisher: DataPublisher<Void?>
    private let builder: SplashBuilderRoutProtocol
    
    init(builder: SplashBuilderRoutProtocol) {
        self.builder = builder
        self.internalEvent = DataPublisher()
        self.externalDataPublisher = DataPublisher()
        self.externalEvent = AnyPublisher(externalDataPublisher)
        setupObservers()
    }
    
}

// MARK: Private
private extension SplashRouter {
    
    func setupObservers() {
        internalEvent.sink { [weak self] in
            self?.internalEventHandler($0)
        }
    }
    
    func internalEventHandler(_ event: SplashRouterInternalEvent) {
        switch event {
            case .inject(let value):
                guard self.viewController == nil else { return }
                self.viewController = value
            
            case .start:
                builder.window?.rootViewController = viewController
            
            case .action:
                externalDataPublisher.send(nil)
        }
    }
    
}

// MARK: - SplashRouterInternalEvent
enum SplashRouterInternalEvent {
    case inject(viewController: UIViewController?)
    case start
    case action
}
