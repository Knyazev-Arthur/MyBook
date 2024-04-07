import Foundation

protocol SplashRouterProtocol: AnyObject {
    var action: (() -> Void)? { get set }
    func sendEvent(_ event: SplashRouterInternalEvent)
}
