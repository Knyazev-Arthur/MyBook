import Foundation

class FavoritesViewModel: FavoritesViewModelProtocol {
    
    var action: (() -> Void)?
    
    private weak var router: FavoritesRouterProtocol?
    
    init(router: FavoritesRouterProtocol?) {
        self.router = router
    }
    
    func sendEvent() {}
    
}
