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
        viewModel.internalEvent.send(.initialSetup)
    }

}

// MARK: Private
private extension AuthorizationViewController {
    
    private func setupObservers() {
        myView.externalEvent.sink { [weak self] _ in
            self?.viewModel.internalEvent.send(.router)
        }
        
        viewModel.externalEvent.sink { [weak self] in
            self?.myView.setViewData($0)
        }
    }
    
}
