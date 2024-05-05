import Foundation

class MenuViewModel: MenuViewModelProtocol {
    
    var action: (() -> Void)?
    
    private weak var router: MenuRouterProtocol?
    private let tabBarAppearance: TabBarAppearanceProtocol
    
    init(router: MenuRouterProtocol?, tabBarAppearance: TabBarAppearanceProtocol) {
        self.router = router
        self.tabBarAppearance = tabBarAppearance
    }
    
    func sendEvent() {
        tabBarAppearance.sendEvent(.updateTabBar)
    }
    
}
