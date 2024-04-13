import Foundation
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
        googleService()
    }
    
    func keyWindow() {
        let window = UIWindow()
        window.makeKeyAndVisible()
        injector.addObject(to: .application, value: window)
    }
    
    func googleService() {
        let googleService = GIDSignIn.sharedInstance
        injector.addObject(to: .application, value: googleService)
    }
    
}

// MARK: Public
extension AppBuilder {
    
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
        guard let googleService = injector.getObject(from: .application, type: GIDSignIn.self) else { return nil }
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
