import Foundation
import Combine

protocol AppUserLoginProtocol: AnyObject {
    var internalEventPublisher: PassthroughSubject<AppUserLoginInternalEvent, Never> { get }
    var externalEventPublisher: AnyPublisher<Result<String, Error>, Never> { get }
}
