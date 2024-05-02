import UIKit

class SplashViewController: UIViewController {
    
    private let viewModel: SplashViewModelProtocol
    private let myView: SplashViewProtocol
    
    init(viewModel: SplashViewModelProtocol, view: SplashViewProtocol) {
        self.viewModel = viewModel
        self.myView = view
        super.init(nibName: nil, bundle: nil)
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.sendEvent()
    }
    
    private func setupObservers() {
        viewModel.action = { [weak self] in
            self?.myView.sendEvent($0)
        }
    }
    
}
