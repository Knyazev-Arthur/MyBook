import Foundation

protocol SplashRouterProtocol: AnyObject {
    var actionSubscriber: AnyPublisher<Void> { get }
    func sendEvent(_ event: SplashRouterInternalEvent)
}
