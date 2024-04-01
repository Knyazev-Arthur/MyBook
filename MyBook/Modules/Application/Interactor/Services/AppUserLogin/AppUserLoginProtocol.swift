import GoogleSignIn

protocol AppUserLoginProtocol: AnyObject {
    var action: ((GIDGoogleUser?) -> Void)? { get set }
    func sendEvent()
}
