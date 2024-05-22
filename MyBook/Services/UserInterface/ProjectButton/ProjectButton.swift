import UIKit
import Combine

class ProjectButton: UIButton, ProjectButtonProtocol {
    
    let publisher: AnyPublisher<Void, Never>
    
    private let internalPublisher: PassthroughSubject<Void, Never>
    
    init(_ touchEvent: UIControl.Event) {
        self.internalPublisher = PassthroughSubject<Void, Never>()
        self.publisher = AnyPublisher(internalPublisher)
        super.init(frame: .zero)
        addTarget(touchEvent)
    }
    
    @objc private func tapButton() {
        internalPublisher.send()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget(_ touchEvent: UIControl.Event) {
        addTarget(self, action: #selector(tapButton), for: touchEvent)
    }
    
    func removeTarget(_ touchEvent: UIControl.Event) {
        removeTarget(self, action: #selector(tapButton), for: touchEvent)
    }
    
}
