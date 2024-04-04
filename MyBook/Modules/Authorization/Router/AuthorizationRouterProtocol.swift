import Foundation

protocol AuthorizationRouterProtocol: AnyObject {
    func sendEvent(_ event: AuthorizationRouterInternalEvent)
}
