import Foundation

protocol FavoritesRouterProtocol: AnyObject {
    var action: (() -> Void)? { get set }
    func sendEvent(_ event: FavoritesRouterInternalEvent)
}
