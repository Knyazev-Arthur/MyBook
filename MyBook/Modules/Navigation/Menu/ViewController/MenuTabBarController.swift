import Foundation
import UIKit

class MenuTabBarController: UITabBarController {
    
    private let viewModel: MenuViewModelProtocol
    
    init(viewModel: MenuViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
