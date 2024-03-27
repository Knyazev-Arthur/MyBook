import Foundation
import GoogleSignIn

class AppBuilder: AppBuilderProtocol {

    func googleService() -> GIDSignIn {
        GIDSignIn.sharedInstance
    }
    
    func userLogin(_ googleService: GIDSignIn) -> AppUserLoginProtocol {
        AppUserLogin(googleService: googleService)
    }
    
}

// MARK: Protocol
extension AppBuilder {
    
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
        SplashBuilder()
    }
    
    var authorizationBuilder: AuthorizationBuilderProtocol? {
        AuthorizationBuilder()
    }
    
}
