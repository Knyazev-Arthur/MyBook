import Foundation
import Combine

protocol SplashRouterProtocol: AnyObject {
    var externalEventPublisher: AnyPublisher<Void?, Never> { get }
    var internalEventPublisher: PassthroughSubject<SplashRouterInternalEvent, Never> { get }
}
