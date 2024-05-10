import Foundation

protocol AuthorizationRouterProtocol: AnyObject {
    var action: ExternalEventManager<AuthorizationRouterExternalEvent>? { get }
    func sendEvent(_ event: AuthorizationRouterInternalEvent)
}
