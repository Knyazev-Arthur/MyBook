import Foundation

protocol AppUserLoginProtocol: AnyObject {
    var externalEvent: AnyPublisher<Result<String, Error>> { get }
    var internalEvent: DataPublisher<AppUserLoginInternalEvent> { get }
}
