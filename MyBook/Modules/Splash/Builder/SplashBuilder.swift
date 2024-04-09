import Foundation
import UIKit

class SplashBuilder: SplashBuilderProtocol {
    
    private let injector: InjectorProtocol
    
    init(injector: InjectorProtocol) {
        self.injector = injector
        register()
    }
    
}

// MARK: Private
private extension SplashBuilder {
    
    func register() {
        screenRouter()
        viewController()
    }
    
    func screenRouter() {
        let window = injector.getObject(from: .application, type: UIWindow.self)
        let router = SplashRouter(window: window)
        injector.addObject(to: .splash, value: router)
    }
    
    func viewController() {
        guard let router = injector.getObject(from: .splash, type: SplashRouter.self) else { return }
        
        let viewModel = viewModel(router)
        let imageView = imageView()
        let view = view(imageView)
        let viewController = SplashViewController(viewModel: viewModel, view: view)
        
        router.sendEvent(.inject(viewController: viewController))
        injector.addObject(to: .splash, value: viewController)
    }
    
}

// MARK: Public
extension SplashBuilder {
    
    func view(_ imageView: UIImageView) -> SplashViewProtocol {
        SplashView(imageView: imageView)
    }
    
    func imageView() -> UIImageView {
        UIImageView()
    }
    
    func viewModel(_ router: SplashRouterProtocol) -> SplashViewModelProtocol {
        SplashViewModel(router: router)
    }
    
}

// MARK: Protocol
extension SplashBuilder {
    
    var controller: SplashViewController? {
        injector.getObject(from: .splash, type: SplashViewController.self)
    }
    
    var router: SplashRouterProtocol? {
        injector.getObject(from: .splash, type: SplashRouter.self)
    }

}
