import UIKit

class AuthorizationRouter: AuthorizationRouterProtocol {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}
