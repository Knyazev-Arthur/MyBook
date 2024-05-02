import Foundation

protocol AppUserLoginProtocol: AnyObject {
    var action: ((Result<String, Error>) -> Void)? { get set }
    func sendEvent(_ event: AppUserLoginInternalEvent)
}
