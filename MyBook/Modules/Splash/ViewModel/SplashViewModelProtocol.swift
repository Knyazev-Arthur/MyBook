import Foundation

protocol SplashViewModelProtocol: AnyObject {
    var action: ((Data) -> Void)? { get set }
    func sendEvent()
}
