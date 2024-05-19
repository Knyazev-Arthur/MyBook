import UIKit
import Combine

protocol AuthorizationViewProtocol: UIView {
    var externalEventPublisher: AnyPublisher<Void?, Never> { get }
    func setViewData(_ data: AuthorizationViewData)
}
