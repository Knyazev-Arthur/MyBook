import UIKit

protocol SplashViewModelProtocol: AnyObject {
    var externalEvent: AnyPublisher<UIImage?> { get }
    func sendLogoAndAction()
}
