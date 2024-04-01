import UIKit

class SplashBuilder: SplashBuilderProtocol {
    
    func view(_ imageView: UIImageView) -> SplashViewProtocol {
        SplashView(imageView: imageView)
    }
    
    func imageView() -> UIImageView {
        UIImageView()
    }
    
    func viewModel(_ logoImage: SplashLogoImageProtocol) -> SplashViewModelProtocol {
        SplashViewModel(logoImage: logoImage)
    }
    
    func splashLogoImage() -> SplashLogoImageProtocol {
        SplashLogoImage()
    }
    
}

// MARK: Protocol
extension SplashBuilder {
    
    var controller: SplashViewController? {
        let logoImage = splashLogoImage()
        let viewModel = viewModel(logoImage)
        let imageView = imageView()
        let view = view(imageView)
        let viewController = SplashViewController(viewModel: viewModel, view: view)
        return viewController
    }
    
    var router: SplashRouterProtocol? {
        guard let controller else { return nil }
        return SplashRouter(viewController: controller)
    }
    
}
