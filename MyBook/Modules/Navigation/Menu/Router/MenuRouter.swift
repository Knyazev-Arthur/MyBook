import UIKit

class MenuRouter: MenuRouterProtocol {
    
    let externalEvent: AnyPublisher<Void>
    let internalEvent: DataPublisher<MenuRouterInternalEvent>
    
    private let externalDataPublisher: DataPublisher<Void>
    private let builder: MenuBuilderRoutProtocol
    private weak var tabBarController: UITabBarController?
    
    init(builder: MenuBuilderRoutProtocol) {
        self.builder = builder
        self.externalDataPublisher = DataPublisher()
        self.externalEvent = AnyPublisher(externalDataPublisher)
        self.internalEvent = DataPublisher()
        setupObservers()
    }
    
}

// MARK: Private
private extension MenuRouter {
    
    func setupObservers() {
        internalEvent.sink { [weak self] in
            self?.internalEventHadler($0)
        }
    }
    
    func internalEventHadler(_ event: MenuRouterInternalEvent) {
        switch event {
            case .inject(let value):
                guard self.tabBarController == nil else { return }
                self.tabBarController = value
            
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
