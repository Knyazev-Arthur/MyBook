import Foundation

protocol MainViewModelProtocol {
    var action: (() -> Void)? { get set }
    func sendEvent()
}
