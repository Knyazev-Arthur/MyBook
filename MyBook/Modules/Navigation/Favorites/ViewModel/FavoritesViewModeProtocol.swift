import Foundation

protocol FavoritesViewModelProtocol: AnyObject {
    var action: (() -> Void)? { get set }
    func sendEvent()
}
