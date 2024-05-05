import SnapKit
import UIKit

class MainView: UIView, MainViewProtocol {
    
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
private extension MainView {
    
    func setupConfiguration() {
        backgroundColor = .lightBeige
    }
    
}
