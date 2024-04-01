import UIKit

class SplashRouter: SplashRouterProtocol {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}
