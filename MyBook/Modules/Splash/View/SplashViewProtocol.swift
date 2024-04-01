import UIKit

protocol SplashViewProtocol: UIView {
    var action: (() -> Void)? { get set }
    func sendEvent(_ image: UIImage)
}
