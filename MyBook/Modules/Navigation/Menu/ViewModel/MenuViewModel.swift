import Foundation

class MenuViewModel: MenuViewModelProtocol {
    
    var action: (() -> Void)?
    
    private weak var router: MenuRouterProtocol?
    
    init(router: MenuRouterProtocol?) {
        self.router = router
    }
    
    func sendEvent() {}
    
}
