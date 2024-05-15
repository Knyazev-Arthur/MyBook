import UIKit

class MenuRouter: MenuRouterProtocol {
    
    let externalEvent: AnyPublisher<Void>
    let internalEvent: DataPublisher<MenuRouterInternalEvent>
    
    private let dataPublisher: DataPublisher<Void>
    private let builder: MenuBuilderRoutProtocol
    private weak var tabBarController: UITabBarController?
    
    init(builder: MenuBuilderRoutProtocol) {
        dataPublisher = DataPublisher<Void>()
        externalEvent = AnyPublisher(dataPublisher)
        internalEvent = DataPublisher<MenuRouterInternalEvent>()
        self.builder = builder
        setupObservers()
    }
    
}

// MARK: Private
private extension MenuRouter {
    
    func setupObservers() {
        internalEvent.sink { [weak self] event in
            self?.internalEventHadler(event)
        }
    }
    
    func internalEventHadler(_ event: MenuRouterInternalEvent?) {
        switch event {
            case .inject(let tabBarController):
                self.tabBarController = tabBarController
            
            case .start:
                setRootTabBarController()
        
            case .none:
                break
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
