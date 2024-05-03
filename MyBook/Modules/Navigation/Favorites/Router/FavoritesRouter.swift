import UIKit

class FavoritesRouter: FavoritesRouterProtocol {
    
    var action: (() -> Void)?
    
    private weak var navigationController: UINavigationController?
    private let builder: FavoritesBuilderRoutProtocol
    
    init(builder: FavoritesBuilderRoutProtocol) {
        self.builder = builder
    }
    
    func sendEvent(_ event: FavoritesRouterInternalEvent) {
        internalEventHadler(event)
    }
    
}

// MARK: Private
private extension FavoritesRouter {
    
    func internalEventHadler(_ event: FavoritesRouterInternalEvent) {
        switch event {
            case .inject(let navigationController):
                self.navigationController = navigationController
            case .start:
                RootController.setRootNavigationController(builder.window, navigationController)
        }
    }
    
}

// MARK: - FavoritesRouterInternalEvent
enum FavoritesRouterInternalEvent {
    case inject(navigationController: UINavigationController?)
    case start
}
