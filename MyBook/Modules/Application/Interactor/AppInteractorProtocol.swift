import Foundation

protocol AppInteractorProtocol: AnyObject {
    var externalEvent: AnyPublisher<AppInteractorExternalEvent> { get }
    func restorePreviousSignIn()
}
