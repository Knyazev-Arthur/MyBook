import UIKit
import GoogleSignIn

protocol AuthorizationBuilderRoutProtocol {
    var googleService: GIDSignIn? { get }
    var window: UIWindow? { get }
}
