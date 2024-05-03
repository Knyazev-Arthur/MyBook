import UIKit

protocol FavoritesViewProtocol: UIView {
    var action: (() -> Void)? { get set }
    func sendEvent()
}
