import Foundation

protocol AuthorizationViewModelProtocol: AnyObject {
    var action: ((AuthorizationViewData) -> Void)? { get set }
    func sendEvent(_ event: AuthorizationViewModelInternalEvent)
}
