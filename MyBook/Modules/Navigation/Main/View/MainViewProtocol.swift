import UIKit

protocol MainViewProtocol: UIView {
    var action: (() -> Void)? { get set }
    func sendEvent()
}
