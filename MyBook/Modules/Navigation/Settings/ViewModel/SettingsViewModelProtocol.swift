import Foundation

protocol SettingsViewModelProtocol: AnyObject {
    var action: (() -> Void)? { get set }
    func sendEvent()
}
