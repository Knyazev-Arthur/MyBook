import UIKit

class MainNavigationController: UINavigationController {
    
    private let viewModel: MainViewModelProtocol
    private let myView: MainViewProtocol
    
    init(viewModel: MainViewModelProtocol, view: MainViewProtocol) {
        self.viewModel = viewModel
        self.myView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = myView
    }
    
}
