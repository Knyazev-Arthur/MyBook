import Foundation
import GoogleSignIn

protocol AppUserLoginProtocol: AnyObject {
    var action: ((AppInteractorUserStatus) -> Void)? { get set }
    var completeAction: (() -> Void)? { get set }
    func sendEvent(_ event: AppUserLoginInternalEvent)
}
