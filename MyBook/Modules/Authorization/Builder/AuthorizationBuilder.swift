import GoogleSignIn

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
        let router = AuthorizationRouter()
        injector.addObject(to: .authorization, value: router)
    }
    
    func viewController() {
        guard let router = injector.getObject(from: .authorization, type: AuthorizationRouter.self) else { return }
                
        let googleService = googleService()
        let userLogin = userLogin(googleService)
        let viewModel = viewModel(router, userLogin)
        let label = label()
        let googleButton = googleButton()
        let view = view(label, googleButton)
        let viewController = AuthorizationViewController(viewModel: viewModel, view: view)
        
        router.sendEvent(.inject(viewController: viewController))
        userLogin.viewController = viewController
        injector.addObject(to: .authorization, value: viewController)
    }
    
}

// MARK: Public
extension AuthorizationBuilder {
    
    func viewController(_ viewModel: AuthorizationViewModelProtocol, _ view: AuthorizationViewProtocol) -> AuthorizationViewController {
        AuthorizationViewController(viewModel: viewModel, view: view)
    }
    
    func view(_ label: UILabel, _ loginButton: GIDSignInButton) -> AuthorizationViewProtocol {
        AuthorizationView(label: label, loginButton: loginButton)
    }
    
    func label() -> UILabel {
        UILabel()
    }
    
    func googleButton() -> GIDSignInButton {
        GIDSignInButton()
    }
    
    func viewModel(_ router: AuthorizationRouterProtocol, _ userLogin: AuthorizationUserLoginProtocol) -> AuthorizationViewModelProtocol {
        AuthorizationViewModel(router: router, userLogin: userLogin)
    }
    
    func userLogin(_ googleService: GIDSignIn) -> AuthorizationUserLoginProtocol {
        AuthorizationUserLogin(googleService: googleService)
    }
    
    func googleService() -> GIDSignIn {
        GIDSignIn.sharedInstance
    }
    
}

// MARK: Protocol
extension AuthorizationBuilder {
    
    var controller: AuthorizationViewController? {
        injector.getObject(from: .authorization, type: AuthorizationViewController.self)
    }
    
    var router: AuthorizationRouterProtocol? {
        injector.getObject(from: .authorization, type: AuthorizationRouter.self)
    }
    
}
