import Foundation

class MainViewModel: MainViewModelProtocol {
    
    var action: (() -> Void)?
    
    private weak var router: MainRouterProtocol?
    
    init(router: MainRouterProtocol?) {
        self.router = router
    }
    
    func sendEvent() {}
    
}
