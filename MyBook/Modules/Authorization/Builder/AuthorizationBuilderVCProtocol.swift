import UIKit
import GoogleSignIn

protocol AuthorizationBuilderVCProtocol {
    var googleService: GIDSignIn? { get }
    var blankSreen: UIViewController { get }
}
