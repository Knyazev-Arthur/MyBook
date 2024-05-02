import Foundation

class AppCoordinator: AppCoordinatorProtocol {
    
    private let builder: AppBuilderProtocol
    private let interactor: AppInteractorProtocol
    private var routers: [AppCoordinatorKey : Any]
    
    init(builder: AppBuilderProtocol, interactor: AppInteractorProtocol) {
        self.builder = builder
        self.interactor = interactor
        self.routers = [AppCoordinatorKey : Any]()
        setupObservers()
    }
    
    func start() -> Bool {
        startSplashModule()
        return true
    }

}

// MARK: Private
private extension AppCoordinator {
    
    func setupObservers() {
        interactor.action = { [weak self] in
            self?.interactorEventHandler($0)
        }
    }
    
    func interactorEventHandler(_ event: AppInteractorExternalEvent) {
        switch event {
            case .authorization(let status):
                userAuthorizationHandler(status)
            
            case .pushNotitication(_):
                break
        }
    }
    
    func userAuthorizationHandler(_ status: UserLoginEventHandler) {
        switch status {
            case .unavaliable:
                startAuthorizationModule()
            
            case .avaliable:
                startMenuModule()
        }
    }
    
    func startSplashModule() {
        guard let builder = builder.splashBuilder, let router = builder.router else {
            fatalError("There aren't any significant splash module objects")
        }
        
        router.sendEvent(.start)
        routers[.splash] = router
        
        router.action = { [weak self] in
            self?.interactor.sendEvent()
        }
    }
    
    func startAuthorizationModule() {
        guard let builder = builder.authorizationBuilder, let router = builder.router else {
            fatalError("There aren't any significant authorization module objects")
        }
        
        router.sendEvent(.start)
        routers[.authorization] = router
        routers[.splash] = nil
        
        router.actionСomplete = { [weak self] in
            self?.startMenuModule()
        }
    }
    
    func startMenuModule() {
        guard let builder = builder.menuBuilder, let router = builder.router else {
            fatalError("There aren't any significant menu module objects")
        }
        
        router.sendEvent(.start)
        routers[.menu] = router
        routers[.authorization] = nil
    }
    
}

// MARK: - AppCoordinatorKey
fileprivate enum AppCoordinatorKey: Hashable {
    case splash
    case authorization
    case menu
}
