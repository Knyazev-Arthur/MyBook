import UIKit

class MainRouter: MainRouterProtocol {
    
    var action: (() -> Void)?
    
    private weak var navigationController: UINavigationController?
    private let builder: MainBuilderRoutProtocol
    
    init(builder: MainBuilderRoutProtocol) {
        self.builder = builder
    }
    
    func sendEvent(_ event: MainRouterInternalEvent) {
        internalEventHadler(event)
    }
    
}

// MARK: Private
private extension MainRouter {
    
    func internalEventHadler(_ event: MainRouterInternalEvent) {
        switch event {
            case .inject(let navigationController):
                self.navigationController = navigationController
            case .start:
                RootController.setRootNavigationController(builder.window, navigationController)
        }
    }
    
}

// MARK: - MainRouterInternalEvent
enum MainRouterInternalEvent {
    case inject(navigationController: UINavigationController?)
    case start
}
