import Foundation
import Combine

protocol AppInteractorProtocol: AnyObject {
    var publisher: AnyPublisher<AppInteractorExternalEvent, Never> { get }
    func restorePreviousSignIn()
}
