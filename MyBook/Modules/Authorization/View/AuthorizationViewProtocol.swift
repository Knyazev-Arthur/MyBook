import UIKit
import Combine

protocol AuthorizationViewProtocol: UIView {
    var publisher: AnyPublisher<Void, Never> { get }
    func setViewData(_ data: AuthorizationViewData)
}
