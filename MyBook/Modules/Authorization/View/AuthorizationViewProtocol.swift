import UIKit

protocol AuthorizationViewProtocol: UIView {
    var action: (() -> Void)? { get set }
    func sendEvent(_ message: String)
}
