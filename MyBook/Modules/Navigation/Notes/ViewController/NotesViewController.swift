import UIKit

class NotesViewController: UIViewController {
    
    private let viewModel: NotesViewModelProtocol
    private let myView: NotesViewProtocol
    
    init(viewModel: NotesViewModelProtocol, view: NotesViewProtocol) {
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
