import Foundation
import GoogleSignIn

protocol AuthorizationRouterProtocol: AnyObject {
    var action: ((Result<GIDGoogleUser?, Error>) -> Void)? { get set }
    var actionСomplete: (() -> Void)? { get set }
    func sendEvent(_ event: AuthorizationRouterInternalEvent)
}
