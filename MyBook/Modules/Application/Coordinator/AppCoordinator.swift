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
    
    func userAuthorizationHandler(_ status: AppInteractorUserStatus) {
        switch status {
            case .unavaliable:
                break
            
            case .avaliable(_):
                break
        }
    }
    
    func startSplashModule() {
        guard let builder = builder.splashBuilder, let controller = builder.controller, let router = builder.router else {
            fatalError("There aren't any significant splash module objects")
        }
        
        router.sendEvent(.setRootVC(controller))
        routers[.splash] = router
        
        router.action = { [weak self] in
            self?.startAuthorizationModule()
            self?.routers[.splash] = nil
        }
    }
    
    func startAuthorizationModule() {
        guard let builder = builder.authorizationBuilder, let controller = builder.controller, let router = builder.router else {
            fatalError("There aren't any significant authorization module objects")
        }
        
        router.sendEvent(.setRootVC(controller))
        routers[.authorization] = router
    }
    
}

// MARK: - AppCoordinatorKey
fileprivate enum AppCoordinatorKey: Hashable {
    case splash
    case authorization
    case menu
}
