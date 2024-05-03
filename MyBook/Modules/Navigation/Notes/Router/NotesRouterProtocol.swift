import Foundation

protocol NotesRouterProtocol: AnyObject {
    var action: (() -> Void)? { get set }
    func sendEvent(_ event: NotesRouterInternalEvent)
}
