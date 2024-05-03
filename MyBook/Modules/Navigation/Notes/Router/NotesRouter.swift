import UIKit

class NotesRouter: NotesRouterProtocol {
    
    var action: (() -> Void)?
    
    private weak var viewController: UIViewController?
    private let builder: NotesBuilderRoutProtocol
    
    init(builder: NotesBuilderRoutProtocol) {
        self.builder = builder
    }
    
    func sendEvent(_ event: NotesRouterInternalEvent) {
        internalEventHadler(event)
    }
    
}

// MARK: Private
private extension NotesRouter {
    
    func internalEventHadler(_ event: NotesRouterInternalEvent) {
        switch event {
            case .inject(let viewController):
                self.viewController = viewController
            case .start:
                RootController.setRootViewController(builder.window, viewController)
        }
    }
    
}

// MARK: - NotesRouterInternalEvent
enum NotesRouterInternalEvent {
    case inject(viewController: UIViewController?)
    case start
}
