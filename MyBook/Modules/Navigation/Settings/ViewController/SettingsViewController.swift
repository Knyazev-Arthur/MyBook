import UIKit

class SettingsViewController: UIViewController {
    
    private let viewModel: SettingsViewModelProtocol
    private let myView: SettingsViewProtocol
    
    init(viewModel: SettingsViewModelProtocol, view: SettingsViewProtocol) {
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
