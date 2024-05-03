import Foundation

protocol SettingsRouterProtocol: AnyObject {
    var action: (() -> Void)? { get set }
    func sendEvent(_ event: SettingsRouterInternalEvent)
}
