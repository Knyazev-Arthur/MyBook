import UIKit

class MenuBuilder: MenuBuilderProtocol {
    
    private let injector: InjectorProtocol
    
    init(injector: InjectorProtocol) {
        self.injector = injector
        register()
    }
    
}

// MARK: Private
private extension MenuBuilder {
    
    func register() {
        screenRouter()
        tabBarController()
    }
    
    func screenRouter() {
        let router = MenuRouter(builder: self)
        injector.addObject(to: .menu, value: router)
    }
    
    func tabBarController() {
        guard let router = injector.getObject(from: .menu, type: MenuRouter.self) else { return }
        
        let viewModel = viewModel(router)
        let tabBarController = MenuTabBarController(viewModel: viewModel)
        
        router.internalEventPublisher.send(.inject(tabBarController: tabBarController))
        injector.addObject(to: .menu, value: tabBarController)
    }

}

// MARK: Public
extension MenuBuilder {
        
    func viewModel(_ router: MenuRouterProtocol) -> MenuViewModel {
        MenuViewModel(router: router)
    }
    
}

// MARK: MenuBuilderProtocol
extension MenuBuilder {
    
    var router: MenuRouterProtocol? {
        injector.getObject(from: .menu, type: MenuRouter.self)
    }
    
    var controller: MenuTabBarController? {
        injector.getObject(from: .menu, type: MenuTabBarController.self)
    }
    
}

// MARK: MenuBuilderRoutProtocol
extension MenuBuilder: MenuBuilderRoutProtocol {
    
    var window: UIWindow? {
        injector.getObject(from: .application, type: UIWindow.self)
    }
    
}
