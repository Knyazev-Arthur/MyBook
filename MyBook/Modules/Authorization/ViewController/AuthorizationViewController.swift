import UIKit
import Combine

class AuthorizationViewController: UIViewController {
    
    private let viewModel: AuthorizationViewModelProtocol
    private let myView: AuthorizationViewProtocol
    private var subscriptions: Set<AnyCancellable>
    
    init(viewModel: AuthorizationViewModelProtocol, view: AuthorizationViewProtocol) {
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
        viewModel.internalEventPublisher.send(.initialSetup)
    }
    
    private func setupObservers() {
        myView.publisher.sink { [weak self] _ in
            self?.viewModel.internalEventPublisher.send(.logInToGoogle)
        }.store(in: &subscriptions)
        
        viewModel.externalEventPublisher.sink { [weak self] in
            self?.myView.setViewData($0)
        }.store(in: &subscriptions)
    }

}
