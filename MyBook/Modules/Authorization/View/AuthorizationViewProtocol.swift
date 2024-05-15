import UIKit

protocol AuthorizationViewProtocol: UIView {
    var externalEvent: AnyPublisher<Void?> { get }
    func setViewData(_ data: AuthorizationViewData)
}
