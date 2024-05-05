import UIKit

class FavoritesBuilder: FavoritesBuilderProtocol {
    
    private let injector: InjectorProtocol
    
    init(injector: InjectorProtocol) {
        self.injector = injector
        register()
    }

}

// MARK: Private
private extension FavoritesBuilder {
    
    func register() {
        screenRouter()
        navigationController()
    }
    
    func screenRouter() {
        let router = FavoritesRouter(builder: self)
        injector.addObject(to: .favorites, value: router)
    }
    
    func navigationController() {
        guard let router = injector.getObject(from: .favorites, type: FavoritesRouter.self) else { return }
        
        let viewModel = viewModel(router)
        let view = view()
        let navigationController = FavoritesNavigationController(viewModel: viewModel, view: view)
        
        router.sendEvent(.inject(navigationController: navigationController))
        injector.addObject(to: .favorites, value: navigationController)
    }

}

// MARK: Public
extension FavoritesBuilder {
        
    func viewModel(_ router: FavoritesRouterProtocol) -> FavoritesViewModel {
        FavoritesViewModel(router: router)
    }
    
    func view() -> FavoritesView {
        FavoritesView()
    }
    
}

// MARK: FavoritesBuilderProtocol
extension FavoritesBuilder {
    
    var router: FavoritesRouterProtocol? {
        injector.getObject(from: .favorites, type: FavoritesRouter.self)
    }
    
    var controller: FavoritesNavigationController? {
        injector.getObject(from: .favorites, type: FavoritesNavigationController.self)
    }
    
}

// MARK: FavoritesBuilderRoutProtocol
extension FavoritesBuilder: FavoritesBuilderRoutProtocol {
    
    var window: UIWindow? {
        injector.getObject(from: .application, type: UIWindow.self)
    }
    
}
