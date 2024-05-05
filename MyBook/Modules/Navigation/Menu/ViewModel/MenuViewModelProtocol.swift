import Foundation

protocol MenuViewModelProtocol: AnyObject {
    var action: (() -> Void)? { get set }
    func sendEvent()
}
