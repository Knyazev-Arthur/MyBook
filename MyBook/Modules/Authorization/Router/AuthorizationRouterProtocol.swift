import Foundation
import GoogleSignIn

protocol AuthorizationRouterProtocol: AnyObject {
    var action: ((GIDSignInResult?, Error?) -> Void)? { get set }
    func sendEvent(_ event: AuthorizationRouterInternalEvent)
}
