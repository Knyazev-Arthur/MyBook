import UIKit
import Combine

protocol ProjectButtonProtocol: UIButton {
    var publisher: AnyPublisher<Void, Never> { get }
    func addTarget(_ touchEvent: UIControl.Event)
    func removeTarget(_ touchEvent: UIControl.Event)
}
