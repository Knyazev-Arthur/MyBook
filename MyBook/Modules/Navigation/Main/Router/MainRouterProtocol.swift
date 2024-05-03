import Foundation

protocol MainRouterProtocol: AnyObject {
    var action: (() -> Void)? { get set }
    func sendEvent(_ event: MainRouterInternalEvent)
}
