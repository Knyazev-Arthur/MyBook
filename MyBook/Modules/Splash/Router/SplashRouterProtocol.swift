import Foundation

protocol SplashRouterProtocol: AnyObject {
    var externalEvent: AnyPublisher<Void?> { get }
    var internalEvent: DataPublisher<SplashRouterInternalEvent> { get }
}
