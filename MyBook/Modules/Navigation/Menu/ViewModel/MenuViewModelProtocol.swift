import Foundation

protocol MenuViewModelProtocol {
    var action: (() -> Void)? { get set }
    func sendEvent()
}
