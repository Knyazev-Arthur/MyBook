import UIKit

class AppCoordinator: AppCoordinatorProtocol {
    
    private let builder: AppBuilderProtocol
    private let interactor: AppInteractorProtocol
    private var routers: [String : Any]
    
    init(builder: AppBuilderProtocol, interactor: AppInteractorProtocol) {
        self.builder = builder
        self.interactor = interactor
        self.routers = [String : Any]()
        setupObservers()
    }
    
    func start(_ window: UIWindow?) -> Bool {
        startAuthorizationModule(window)
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
    
    func startAuthorizationModule(_ window: UIWindow?) {
        guard let window, let builder = builder.authorizationBuilder, let controller = builder.controller, let router = builder.router else {
            fatalError("There aren't any significant authorization module objects")
        }
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
        routers[AppCoordinatorKey.authorization] = router
    }
    
}

// MARK: - AppCoordinatorKey
fileprivate enum AppCoordinatorKey {
    static let authorization = "Authorization"
    static let menu = "Menu"
}
