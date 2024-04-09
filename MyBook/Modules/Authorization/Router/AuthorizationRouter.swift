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
            
            case .setRootVC(let viewController):
                guard let window else { return }
                window.rootViewController = viewController
            
            case .alert:
                break
        }
    }

}

// MARK: - AuthorizationRouterInternalEvent
enum AuthorizationRouterInternalEvent {
    case inject(viewController: UIViewController?)
    case setRootVC(_ viewController: UIViewController?)
    case alert
}
