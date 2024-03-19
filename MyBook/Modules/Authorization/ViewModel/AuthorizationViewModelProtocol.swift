import Foundation

protocol AuthorizationViewModelProtocol: AnyObject {
    var action: ((String) -> Void)? { get set }
    func sendEvent()
}
