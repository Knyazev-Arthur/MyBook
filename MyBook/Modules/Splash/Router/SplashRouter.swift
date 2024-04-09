import Foundation
import UIKit

class SplashRouter: SplashRouterProtocol {
    
    var action: (() -> Void)?
    
    private weak var window: UIWindow?
    private weak var viewController: UIViewController?
    
    init(window: UIWindow?) {
        self.window = window
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
            
            case .setRootVC(_):
                guard let window else { return }
                window.rootViewController = viewController
            
            case .action:
                action?()
        }
    }
    
}

// MARK: - SplashRouterInternalEvent
enum SplashRouterInternalEvent {
    case inject(viewController: UIViewController?)
    case setRootVC(_ viewController: UIViewController?)
    case action
}
