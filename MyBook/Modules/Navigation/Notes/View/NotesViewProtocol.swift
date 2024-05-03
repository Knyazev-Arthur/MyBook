import UIKit

protocol NotesViewProtocol: UIView {
    var action: (() -> Void)? { get set }
    func sendEvent()
}
