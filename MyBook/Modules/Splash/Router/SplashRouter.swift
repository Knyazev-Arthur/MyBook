import UIKit

class SplashRouter: SplashRouterProtocol {
    
    let actionSubscriber: AnyPublisher<Void>
    
    private weak var viewController: UIViewController?
    private let dataPublisher: DataPublisher<Void>
    private let builder: SplashBuilderRoutProtocol
    
    init(dataPublisher: DataPublisher<Void>, builder: SplashBuilderRoutProtocol) {
        self.dataPublisher = dataPublisher
        self.actionSubscriber = AnyPublisher(dataPublisher: dataPublisher)
        self.builder = builder
    }
    
    func sendEvent(_ event: SplashRouterInternalEvent) {
        internalEventHadler(event)
    }
    
}

// MARK: Private
private extension SplashRouter {
    
    func internalEventHadler(_ event: SplashRouterInternalEvent) {
        switch event {
            case .inject(let viewController):
                self.viewController = viewController
            
            case .start:
                builder.window?.rootViewController = viewController
            
            case .action:
                dataPublisher.send(())
        }
    }
    
}

// MARK: - SplashRouterInternalEvent
enum SplashRouterInternalEvent {
    case inject(viewController: UIViewController?)
    case start
    case action
}
