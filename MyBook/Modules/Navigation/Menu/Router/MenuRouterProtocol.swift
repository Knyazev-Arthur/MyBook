import Foundation

protocol MenuRouterProtocol: AnyObject {
    var action: (() -> Void)? { get set }
    func sendEvent(_ event: MenuRouterInternalEvent)
}
