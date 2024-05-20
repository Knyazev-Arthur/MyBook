import UIKit
import Combine

protocol SplashViewModelProtocol: AnyObject {
    var publisher: AnyPublisher<UIImage?, Never> { get }
    func sendLogoAndAction()
}
