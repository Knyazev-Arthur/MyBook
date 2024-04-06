import GoogleSignIn

class AppBuilder: AppBuilderProtocol {
    
    private let injector: InjectorProtocol
    
    init(injector: InjectorProtocol) {
        self.injector = injector
        register()
    }
    
}

// MARK: Private
private extension AppBuilder {
    
    func register() {
        keyWindow()
    }
    
    func keyWindow() {
        let window = UIWindow()
        window.makeKeyAndVisible()
        injector.addObject(to: .application, value: window)
    }
    
}

// MARK: Public
extension AppBuilder {
    
    func googleService() -> GIDSignIn {
        GIDSignIn.sharedInstance
    }
    
    func userLogin(_ googleService: GIDSignIn) -> AppUserLoginProtocol {
        AppUserLogin(googleService: googleService)
    }
    
}

// MARK: Protocol
extension AppBuilder {
    
    var window: UIWindow? {
        injector.getObject(from: .application, type: UIWindow.self)
    }
    
    var interactor: AppInteractorProtocol? {
        let googleService = googleService()
        let userLogin = userLogin(googleService)
        return AppInteractor(userLogin: userLogin)
    }
    
    var coordinator: AppCoordinatorProtocol? {
        guard let interactor else { return nil }
        return AppCoordinator(builder: self, interactor: interactor)
    }
    
    var splashBuilder: SplashBuilderProtocol? {
        SplashBuilder(injector: injector)
    }
    
    var authorizationBuilder: AuthorizationBuilderProtocol? {
        AuthorizationBuilder(injector: injector)
    }
    
}
