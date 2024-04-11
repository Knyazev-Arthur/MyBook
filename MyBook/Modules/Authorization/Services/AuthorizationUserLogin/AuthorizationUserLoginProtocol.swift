import UIKit
import GoogleSignIn

protocol AuthorizationUserLoginProtocol: AnyObject {
    var action: ((String) -> Void)? { get set }
    func sendEvent(_ result: GIDSignInResult?, _ error: Error?)
}
