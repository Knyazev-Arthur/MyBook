import Foundation

protocol FavoritesViewModelProtocol {
    var action: (() -> Void)? { get set }
    func sendEvent()
}
