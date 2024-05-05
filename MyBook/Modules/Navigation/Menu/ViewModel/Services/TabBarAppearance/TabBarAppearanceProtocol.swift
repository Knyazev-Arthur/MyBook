import Foundation

protocol TabBarAppearanceProtocol {
    var action: (() -> Void)? { get set }
    func sendEvent(_ event: TabBarAppearanceInternalEvent)
}
