import SnapKit
import UIKit

class SettingsView: UIView, SettingsViewProtocol {
    
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
private extension SettingsView {
    
    func setupConfiguration() {
        backgroundColor = .lightBeige
    }
    
}
