import UIKit

class AuthorizationViewController: UIViewController {
    
    private let viewModel: AuthorizationViewModelProtocol
    private let myView: AuthorizationViewProtocol
    
    init(viewModel: AuthorizationViewModelProtocol, view: AuthorizationViewProtocol) {
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
        viewModel.sendEvent(.initialSetup)
    }

}

// MARK: Private
private extension AuthorizationViewController {
    
    private func setupObservers() {
        myView.action = { [weak self] in
            self?.viewModel.sendEvent(.router)
        }
        
        viewModel.action = { [weak self] in
            self?.myView.sendEvent($0)
        }
    }
    
}
