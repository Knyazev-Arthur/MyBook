import Foundation

protocol AuthorizationRouterProtocol: AnyObject {
    var actionSubscriber: AnyPublisher<AuthorizationRouterExternalEvent> { get }
    func sendEvent(_ event: AuthorizationRouterInternalEvent)
}
