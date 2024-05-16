import Foundation

protocol AuthorizationViewModelProtocol: AnyObject {
    var externalEvent: AnyPublisher<AuthorizationViewData> { get }
    var internalEvent: DataPublisher<AuthorizationViewModelInternalEvent> { get }
}
