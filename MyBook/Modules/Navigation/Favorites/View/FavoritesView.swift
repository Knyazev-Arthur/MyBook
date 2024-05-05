import SnapKit
import UIKit

class FavoritesView: UIView, FavoritesViewProtocol {
    
    var action: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sendEvent() { }
    
}

// MARK: Private
private extension FavoritesView {
    
    func setupConfiguration() {
        backgroundColor = .lightBeige
    }
    
}
