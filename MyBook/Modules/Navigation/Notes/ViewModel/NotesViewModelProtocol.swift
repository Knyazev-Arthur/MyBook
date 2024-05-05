import Foundation

protocol NotesViewModelProtocol: AnyObject {
    var action: (() -> Void)? { get set }
    func sendEvent()
}
