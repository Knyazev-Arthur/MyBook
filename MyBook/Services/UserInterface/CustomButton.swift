import UIKit
import Combine

class ProjectButton: UIButton {
    
    let tapEventPublisher: AnyPublisher<Void, Never>
    
    private let externalDataPublisher: PassthroughSubject<Void, Never>
    
    init(_ touchEvent: UIControl.Event) {
        self.externalDataPublisher = PassthroughSubject<Void, Never>()
        self.tapEventPublisher = AnyPublisher(externalDataPublisher)
        super.init(frame: .zero)
        addTarget(self, action: #selector(tapButton), for: touchEvent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func removeTarget(_ touchEvent: UIControl.Event) {
        removeTarget(self, action: #selector(tapButton), for: touchEvent)
    }
    
    @objc private func tapButton() {
        externalDataPublisher.send()
    }
    
}
