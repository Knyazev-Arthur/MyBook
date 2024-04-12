import Foundation

protocol AuthorizationViewModelProtocol: AnyObject {
    var action: ((AuthorizationViewInternalEvent) -> Void)? { get set }
    func sendEvent(_ event: AuthorizationViewModelInternalEvent)
}
