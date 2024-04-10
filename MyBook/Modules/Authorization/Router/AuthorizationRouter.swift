import Foundation
import UIKit

class AuthorizationRouter: AuthorizationRouterProtocol {
    
    private weak var viewController: UIViewController?
    private weak var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
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
                window?.layer.add(transition(), forKey: "transition")
                window?.rootViewController = viewController
            
            case .alert:
                break
        }
    }
    
    func transition() -> CATransition {
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 0.4
        return transition
    }

}

// MARK: - AuthorizationRouterInternalEvent
enum AuthorizationRouterInternalEvent {
    case inject(viewController: UIViewController?)
    case start
    case alert
}
