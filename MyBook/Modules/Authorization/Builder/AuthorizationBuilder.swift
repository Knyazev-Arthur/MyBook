import GoogleSignIn
import UIKit

class AuthorizationBuilder: AuthorizationBuilderProtocol {
    
    private let injector: InjectorProtocol
    
    init(injector: InjectorProtocol) {
        self.injector = injector
        register()
    }

}

// MARK: Private
private extension AuthorizationBuilder {
    
    func register() {
        screenRouter()
        viewController()
    }
    
    func screenRouter() {
        let action = externalEventManager()
        let router = AuthorizationRouter(builder: self, action: action)
        injector.addObject(to: .authorization, value: router)
    }
    
    func viewController() {
        guard let router = injector.getObject(from: .authorization, type: AuthorizationRouter.self) else { return }
        guard let googleService = injector.getObject(from: .application, type: GIDSignIn.self) else { return }
        
        let userLogin = userLogin(googleService)
        let viewModel = viewModel(router, userLogin)
        let logoImageView = imageView()
        let label = label()
        let googleButton = googleButton()
        let view = view(logoImageView, label, googleButton)
        let viewController = AuthorizationViewController(viewModel: viewModel, view: view)
        
        router.sendEvent(.inject(viewController: viewController))
        injector.addObject(to: .authorization, value: viewController)
    }

}

// MARK: Public
extension AuthorizationBuilder {

    func imageView() -> UIImageView {
        UIImageView()
    }
    
    func label() -> UILabel {
        UILabel()
    }
    
    func googleButton() -> UIButton {
        UIButton()
    }
    
    func viewModel(_ router: AuthorizationRouterProtocol, _ userLogin: AppUserLoginProtocol) -> AuthorizationViewModelProtocol {
        AuthorizationViewModel(router: router, userLogin: userLogin)
    }
    
    func userLogin(_ googleService: GIDSignIn) -> AppUserLoginProtocol {
        AppUserLogin(googleService: googleService)
    }
    
    func view(_ logoImageView: UIImageView, _ label: UILabel, _ loginButton: UIButton) -> AuthorizationViewProtocol {
        AuthorizationView(logoImageView: logoImageView, label: label, loginButton: loginButton)
    }
    
    func externalEventManager() -> ExternalEventManager<AuthorizationRouterExternalEvent> {
        ExternalEventManager<AuthorizationRouterExternalEvent>()
    }

}

// MARK: AuthorizationBuilderProtocol
extension AuthorizationBuilder {
    
    var controller: AuthorizationViewController? {
        injector.getObject(from: .authorization, type: AuthorizationViewController.self)
    }
    
    var router: AuthorizationRouterProtocol? {
        injector.getObject(from: .authorization, type: AuthorizationRouter.self)
    }

}

// MARK: AuthorizationBuilderRoutProtocol
extension AuthorizationBuilder: AuthorizationBuilderRoutProtocol {
    
    var window: UIWindow? {
        injector.getObject(from: .application, type: UIWindow.self)
    }

    var googleService: GIDSignIn? {
        injector.getObject(from: .application, type: GIDSignIn.self)
    }
    
}
