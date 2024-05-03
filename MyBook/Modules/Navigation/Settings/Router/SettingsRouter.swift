import UIKit

class SettingsRouter: SettingsRouterProtocol {
    
    var action: (() -> Void)?
    
    private weak var viewController: UIViewController?
    private let builder: SettingsBuilderRoutProtocol
    
    init(builder: SettingsBuilderRoutProtocol) {
        self.builder = builder
    }
    
    func sendEvent(_ event: SettingsRouterInternalEvent) {
        internalEventHadler(event)
    }
    
}

// MARK: Private
private extension SettingsRouter {
    
    func internalEventHadler(_ event: SettingsRouterInternalEvent) {
        switch event {
            case .inject(let viewController):
                self.viewController = viewController
            
            case .start:
                RootController.setRootViewController(builder.window, viewController)
        }
    }
    
}

// MARK: - SettingsRouterInternalEvent
enum SettingsRouterInternalEvent {
    case inject(viewController: UIViewController?)
    case start
}
