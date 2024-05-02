import UIKit

protocol SplashViewModelProtocol: AnyObject {
    var action: ((UIImage?) -> Void)? { get set }
    func sendEvent()
}
