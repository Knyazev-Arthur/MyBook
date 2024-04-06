import Foundation
import UIKit

class SplashRouter: SplashRouterProtocol {
    
    var action: (() -> Void)?
    
    private weak var viewController: UIViewController?
    
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

            case .action:
                action?()
        }
    }
    
}

// MARK: - SplashRouterInternalEvent
enum SplashRouterInternalEvent {
    case inject(viewController: UIViewController?)
    case action
}
