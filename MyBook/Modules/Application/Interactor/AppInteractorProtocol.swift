import Foundation

protocol AppInteractorProtocol: AnyObject {
    var action: ((AppInteractorExternalEvent) -> Void)? { get set }
    func sendEvent()
}
