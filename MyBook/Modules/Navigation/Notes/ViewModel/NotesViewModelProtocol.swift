import Foundation

protocol NotesViewModelProtocol {
    var action: (() -> Void)? { get set }
    func sendEvent()
}
