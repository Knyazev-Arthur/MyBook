import UIKit
import Combine

final class CustomButton: UIButton {
    
    let externalEventPublisher: AnyPublisher<Void, Never>
    private let externalDataPublisher: PassthroughSubject<Void, Never>
    
    init() {
        self.externalDataPublisher = PassthroughSubject<Void, Never>()
        self.externalEventPublisher = AnyPublisher(externalDataPublisher)
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func target(_ touchEvent: UIControl.Event) {
        addTarget(self, action: #selector(tapButton), for: touchEvent)
    }
    
    @objc private func tapButton() {
        externalDataPublisher.send()
    }
    
}
