import Foundation
import Combine

class MenuViewModel: MenuViewModelProtocol {

    private weak var router: MenuRouterProtocol?
    
    init(router: MenuRouterProtocol?) {
        self.router = router
    }
        
}
