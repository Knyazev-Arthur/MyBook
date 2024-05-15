import Foundation

protocol MenuViewModelProtocol {
    var externalEvent: AnyPublisher<Void> { get }
    func internalEvent()
}
