import GoogleSignIn

class AuthorizationBuilder: AuthorizationBuilderProtocol {
    
    func view(_ label: UILabel, _ loginButton: GIDSignInButton) -> AuthorizationViewProtocol {
        AuthorizationView(label: label, loginButton: loginButton)
    }
    
    func label() -> UILabel {
        UILabel()
    }
    
    func googleButton() -> GIDSignInButton {
        GIDSignInButton()
    }
    
    func viewModel(_ userLogin: AuthorizationUserLoginProtocol) -> AuthorizationViewModelProtocol {
        AuthorizationViewModel(userLogin: userLogin)
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
        let googleService = googleService()
        let userLogin = userLogin(googleService)
        let viewModel = viewModel(userLogin)
        let label = label()
        let googleButton = googleButton()
        let view = view(label, googleButton)
        let viewController = AuthorizationViewController(viewModel: viewModel, view: view)
        userLogin.viewController = viewController
        return viewController
    }
    
    var router: AuthorizationRouterProtocol? {
        guard let controller else { return nil }
        return AuthorizationRouter(viewController: controller)
    }
    
}
