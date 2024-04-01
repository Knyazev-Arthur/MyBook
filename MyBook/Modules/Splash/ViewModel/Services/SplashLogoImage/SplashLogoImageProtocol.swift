import Foundation

protocol SplashLogoImageProtocol: AnyObject {
    var action: ((Data) -> Void)? { get set }
    func sendEvent()
}
