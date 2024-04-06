import Foundation
import UIKit

class SplashViewModel: SplashViewModelProtocol {
    
    var action: ((UIImage?) -> Void)?
    
    private weak var router: SplashRouterProtocol?
    
    init(router: SplashRouterProtocol?) {
        self.router = router
    }
    
    func sendEvent() {
        let image = UIImage(named: "Logo")
        action?(image)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.router?.sendEvent(.action)
        }
    }
    
}
