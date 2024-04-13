import Foundation
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
        setupInitialViewModelEvents()
    }

}

// MARK: Private
private extension AuthorizationViewController {
    
    private func setupObservers() {
        myView.action = { [weak self] in
            self?.viewModel.sendEvent(.router)
        }
        
        viewModel.action = { [weak self] event in
            self?.handleViewModelEvent(event)
        }
        
    }
    
    func handleViewModelEvent(_ event: AuthorizationViewInternalEvent) {
        switch event {
            case .imageLogo(let image):
                myView.sendEvent(.imageLogo(image))
            case .message(let message):
                myView.sendEvent(.message(message))
            case .imageLoginButton(let image):
                myView.sendEvent(.imageLoginButton(image))
            case .textLabelGreeting(let text):
                myView.sendEvent(.textLabelGreeting(text))
        }
    }
    
    func setupInitialViewModelEvents() {
        viewModel.sendEvent(.imageLogo)
        viewModel.sendEvent(.imageLoginButton)
        viewModel.sendEvent(.textLabelGreating)
    }
    
}
