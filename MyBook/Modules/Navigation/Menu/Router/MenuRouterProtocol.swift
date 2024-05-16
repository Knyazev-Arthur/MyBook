import Foundation

protocol MenuRouterProtocol: AnyObject {
    var externalEvent: AnyPublisher<Void> { get }
    var internalEvent: DataPublisher<MenuRouterInternalEvent> { get }
}
