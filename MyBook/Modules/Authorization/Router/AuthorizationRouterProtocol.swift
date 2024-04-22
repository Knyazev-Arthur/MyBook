import Foundation
import GoogleSignIn

protocol AuthorizationRouterProtocol: AnyObject {
    var action: ((AuthorizationRouterExternalEvent) -> Void)? { get set }
    func sendEvent(_ event: AuthorizationRouterInternalEvent)
}
