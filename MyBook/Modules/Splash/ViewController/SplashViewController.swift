import UIKit
import Combine

class SplashViewController: UIViewController {
    
    private let viewModel: SplashViewModelProtocol
    private let myView: SplashViewProtocol
    private var subscriptions: Set<AnyCancellable>
    
    init(viewModel: SplashViewModelProtocol, view: SplashViewProtocol) {
        self.viewModel = viewModel
        self.myView = view
        self.subscriptions = Set<AnyCancellable>()
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
        viewModel.sendLogoAndAction()
    }
    
    private func setupObservers() {
        viewModel.publisher.sink { [weak self] in
            self?.myView.setLogo($0)
        }.store(in: &subscriptions)
    }
    
}
