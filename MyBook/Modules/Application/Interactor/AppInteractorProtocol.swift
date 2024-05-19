import Foundation
import Combine

protocol AppInteractorProtocol: AnyObject {
    var externalEventPublisher: AnyPublisher<AppInteractorExternalEvent, Never> { get }
    func restorePreviousSignIn()
}
