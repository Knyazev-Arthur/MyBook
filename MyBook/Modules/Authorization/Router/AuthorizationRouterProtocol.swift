import Foundation

protocol AuthorizationRouterProtocol: AnyObject {
    var externalEvent: AnyPublisher<AuthorizationRouterExternalEvent> { get }
    var internalEvent: DataPublisher<AuthorizationRouterInternalEvent> { get }
}
