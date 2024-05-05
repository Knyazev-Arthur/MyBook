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
        guard let mainNavigationController = mainBuilder?.controller else { return }
        guard let favoritesNavigationController = favoritesBuilder?.controller else { return }
        guard let notesViewController = notesBuilder?.controller else { return }
        guard let settingsViewController = settingsBuilder?.controller else { return }
        
        let arrayViewControllers = [mainNavigationController, favoritesNavigationController, notesViewController, settingsViewController]
        let tabBarAppearance = tabBarAppearance()
        let viewModel = viewModel(router, tabBarAppearance)
        let tabBarController = MenuTabBarController(viewModel: viewModel)
        tabBarController.setViewControllers(arrayViewControllers, animated: true)
        
        tabBarAppearance.sendEvent(.inject(tabBarController: tabBarController))
        router.sendEvent(.inject(tabBarController: tabBarController))
        injector.addObject(to: .menu, value: tabBarController)
    }

}

// MARK: Public
extension MenuBuilder {
        
    func viewModel(_ router: MenuRouterProtocol, _ tabBarAppearance: TabBarAppearanceProtocol) -> MenuViewModel {
        MenuViewModel(router: router, tabBarAppearance: tabBarAppearance)
    }
    
    func tabBarAppearance() -> TabBarAppearanceProtocol {
        TabBarAppearance()
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
    
    var mainBuilder: MainBuilderProtocol? {
        MainBuilder(injector: injector)
    }
    
    var favoritesBuilder: FavoritesBuilderProtocol? {
        FavoritesBuilder(injector: injector)
    }
    
    var notesBuilder: NotesBuilderProtocol? {
        NotesBuilder(injector: injector)
    }
    
    var settingsBuilder: SettingsBuilderProtocol? {
        SettingsBuilder(injector: injector)
    }
    
}

// MARK: MenuBuilderRoutProtocol
extension MenuBuilder: MenuBuilderRoutProtocol {
    
    var window: UIWindow? {
        injector.getObject(from: .application, type: UIWindow.self)
    }
    
}
