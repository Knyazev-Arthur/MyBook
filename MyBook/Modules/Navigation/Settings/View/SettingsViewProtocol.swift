import UIKit

protocol SettingsViewProtocol: UIView {
    var action: (() -> Void)? { get set }
    func sendEvent()
}
