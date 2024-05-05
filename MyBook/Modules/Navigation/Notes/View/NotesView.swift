import SnapKit
import UIKit

class NotesView: UIView, NotesViewProtocol {
    
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
private extension NotesView {
    
    func setupConfiguration() {
        backgroundColor = .lightBeige
    }
    
}
