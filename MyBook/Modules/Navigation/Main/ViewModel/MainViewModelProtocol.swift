import Foundation

protocol MainViewModelProtocol: AnyObject {
    var action: (() -> Void)? { get set }
    func sendEvent()
}
