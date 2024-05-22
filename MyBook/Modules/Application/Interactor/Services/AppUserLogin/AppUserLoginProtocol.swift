import Foundation
import Combine

protocol AppUserLoginProtocol: AnyObject {
    var internalEventPublisher: PassthroughSubject<AppUserLoginInternalEvent, Never> { get }
    var externalEventPublisher: AnyPublisher<String, Error> { get }
}
