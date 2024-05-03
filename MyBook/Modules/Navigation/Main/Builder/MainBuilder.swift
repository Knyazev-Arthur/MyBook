import UIKit

class MainBuilder: MainBuilderProtocol {
    
    private let injector: InjectorProtocol
    
    init(injector: InjectorProtocol) {
        self.injector = injector
    }
    
}

// MARK: Private
private extension MainBuilder {
    
    func register() {
        screenRouter()
        navigationController()
    }
    
    func screenRouter() {
        let router = MainRouter(builder: self)
        injector.addObject(to: .main, value: router)
    }
    
    func navigationController() {
        guard let router = injector.getObject(from: .main, type: MainRouter.self) else { return }
        
        let viewModel = viewModel(router)
        let view = view()
        let navigationController = MainNavigationController(viewModel: viewModel, view: view)
        
        router.sendEvent(.inject(navigationController: navigationController))
        injector.addObject(to: .menu, value: navigationController)
    }

}

// MARK: Public
extension MainBuilder {
        
    func viewModel(_ router: MainRouterProtocol) -> MainViewModel {
        MainViewModel(router: router)
    }
    
    func view() -> MainView {
        MainView()
    }
    
}

// MARK: MainBuilderProtocol
extension MainBuilder {
    
    var router: MainRouterProtocol? {
        injector.getObject(from: .main, type: MainRouter.self)
    }
    
    var controller: MainNavigationController? {
        injector.getObject(from: .main, type: MainNavigationController.self)
    }
    
}

// MARK: MainBuilderRoutProtocol
extension MainBuilder: MainBuilderRoutProtocol {
    
    var window: UIWindow? {
        injector.getObject(from: .application, type: UIWindow.self)
    }
    
}
