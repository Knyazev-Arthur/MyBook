import Foundation
import Combine

protocol AuthorizationViewModelProtocol: AnyObject {
    var internalEventPublisher: PassthroughSubject<AuthorizationViewModelInternalEvent, Never> { get }
    var externalEventPublisher: AnyPublisher<AuthorizationViewData, Never> { get }
}
