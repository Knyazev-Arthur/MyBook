import UIKit

class FavoritesNavigationController: UINavigationController {
    
    private let viewModel: FavoritesViewModelProtocol
    private let myView: FavoritesViewProtocol
    
    init(viewModel: FavoritesViewModelProtocol, view: FavoritesViewProtocol) {
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
