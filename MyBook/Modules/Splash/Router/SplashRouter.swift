import Foundation
import UIKit

class SplashRouter: SplashRouterProtocol {
    
    var action: (() -> Void)?
    
    private weak var viewController: UIViewController?
    private let builder: SplashBuilderRoutProtocol
    
    init(builder: SplashBuilderRoutProtocol) {
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
                action?()
        }
    }
    
}

// MARK: - SplashRouterInternalEvent
enum SplashRouterInternalEvent {
    case inject(viewController: UIViewController?)
    case start
    case action
}
