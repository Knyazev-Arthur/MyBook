import UIKit

class SplashViewController: UIViewController {
    
    private let viewModel: SplashViewModelProtocol
    private let myView: SplashViewProtocol
    
    init(viewModel: SplashViewModelProtocol, view: SplashViewProtocol) {
        self.viewModel = viewModel
        self.myView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
