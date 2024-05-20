import UIKit
import Combine

protocol ProjectButtonProtocol: UIButton {
    var publisher: AnyPublisher<Void, Never> { get }
    func removeTarget(_ touchEvent: UIControl.Event)
}
