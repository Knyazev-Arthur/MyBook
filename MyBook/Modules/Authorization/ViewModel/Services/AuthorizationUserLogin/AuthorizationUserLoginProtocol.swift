import UIKit

protocol AuthorizationUserLoginProtocol: AnyObject {
    var action: ((String) -> Void)? { get set }
    var viewController: UIViewController? { get set }
    func sendEvent()
}
