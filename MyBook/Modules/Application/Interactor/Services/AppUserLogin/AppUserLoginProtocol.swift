import Foundation
import GoogleSignIn

protocol AppUserLoginProtocol: AnyObject {
    var action: ((AppUserLoginExternalEvent) -> Void)? { get set }
    func sendEvent(_ event: AppUserLoginInternalEvent)
}
