import UIKit

class MenuRouter: MenuRouterProtocol {
    
    var action: (() -> Void)?
    
    private weak var tabBarController: UITabBarController?
    private let builder: MenuBuilderRoutProtocol
    
    init(builder: MenuBuilderRoutProtocol) {
        self.builder = builder
    }
    
    func sendEvent(_ event: MenuRouterInternalEvent) {
        internalEventHadler(event)
    }
    
}

// MARK: Private
private extension MenuRouter {
    
    func internalEventHadler(_ event: MenuRouterInternalEvent) {
        switch event {
            case .inject(let tabBarController):
                self.tabBarController = tabBarController
            
            case .start:
                setRootTabBarController()
        }
    }
    
    func setRootTabBarController() {
        tabBarController?.view.backgroundColor = .yellow
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 0.4
        builder.window?.layer.add(transition, forKey: "transition")
        builder.window?.rootViewController = tabBarController
    }
    
}

// MARK: - AuthorizationRouterInternalEvent
enum MenuRouterInternalEvent {
    case inject(tabBarController: UITabBarController?)
    case start
}
