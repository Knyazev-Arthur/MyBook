import UIKit
import Combine

class MenuRouter: MenuRouterProtocol {
    
    let internalEventPublisher: PassthroughSubject<MenuRouterInternalEvent, Never>
    let externalEventPublisher: AnyPublisher<Void, Never>
    
    private let builder: MenuBuilderRoutProtocol
    private let externalDataPublisher: PassthroughSubject<Void, Never>
    private var subscriptions: Set<AnyCancellable>
    private weak var tabBarController: UITabBarController?
    
    init(builder: MenuBuilderRoutProtocol) {
        self.builder = builder
        self.externalDataPublisher = PassthroughSubject<Void, Never>()
        self.externalEventPublisher = AnyPublisher(externalDataPublisher)
        self.internalEventPublisher = PassthroughSubject<MenuRouterInternalEvent, Never>()
        self.subscriptions = Set<AnyCancellable>()
        setupObservers()
    }
    
}

// MARK: Private
private extension MenuRouter {
    
    func setupObservers() {
        internalEventPublisher.sink { [weak self] in
            self?.internalEventHadler($0)
        }.store(in: &subscriptions)
    }
    
    func internalEventHadler(_ event: MenuRouterInternalEvent) {
        switch event {
            case .inject(let value):
                guard tabBarController == nil else { return }
                tabBarController = value
            
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
