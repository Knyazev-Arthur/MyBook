import UIKit
import Combine

protocol SplashViewModelProtocol: AnyObject {
    var externalEventPublisher: AnyPublisher<UIImage?, Never> { get }
    func sendLogoAndAction()
}
