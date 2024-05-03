import Foundation

class SettingsViewModel: SettingsViewModelProtocol {
    
    var action: (() -> Void)?
    
    private weak var router: SettingsRouterProtocol?
    
    init(router: SettingsRouterProtocol?) {
        self.router = router
    }
    
    func sendEvent() {}
    
}
