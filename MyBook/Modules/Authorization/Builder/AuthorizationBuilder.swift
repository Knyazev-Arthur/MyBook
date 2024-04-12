import Foundation
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
        let window = injector.getObject(from: .application, type: UIWindow.self)
        let googleService = googleService()
        let router = AuthorizationRouter(window: window, googleService: googleService)
        injector.addObject(to: .authorization, value: router)
    }
    
    func viewController() {
        guard let router = injector.getObject(from: .authorization, type: AuthorizationRouter.self) else { return }
        
        let googleService = googleService()
        let userLogin = userLogin(googleService)
        let viewModel = viewModel(router, userLogin)
        let logoImageView = logoImageView()
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
    
    func googleService() -> GIDSignIn {
        GIDSignIn.sharedInstance
    }

    func logoImageView() -> UIImageView {
        UIImageView()
    }
    
    func label() -> UILabel {
        UILabel()
    }
    
    func googleButton() -> UIButton {
        UIButton()
    }
    
    func viewModel(_ router: AuthorizationRouterProtocol, _ userLogin: AuthorizationUserLoginProtocol) -> AuthorizationViewModelProtocol {
        AuthorizationViewModel(router: router, userLogin: userLogin)
    }
    
    func userLogin(_ googleService: GIDSignIn) -> AuthorizationUserLoginProtocol {
        AuthorizationUserLogin(googleService: googleService)
    }
    
    func view(_ logoImageView: UIImageView, _ label: UILabel, _ loginButton: UIButton) -> AuthorizationViewProtocol {
        AuthorizationView(logoImageView: logoImageView, label: label, loginButton: loginButton)
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
