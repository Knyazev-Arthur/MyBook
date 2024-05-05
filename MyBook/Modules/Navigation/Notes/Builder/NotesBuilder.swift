import UIKit

class NotesBuilder: NotesBuilderProtocol {
    
    private let injector: InjectorProtocol
    
    init(injector: InjectorProtocol) {
        self.injector = injector
        register()
    }

}

// MARK: Private
private extension NotesBuilder {
    
    func register() {
        screenRouter()
        viewController()
    }
    
    func screenRouter() {
        let router = NotesRouter(builder: self)
        injector.addObject(to: .notes, value: router)
    }
    
    func viewController() {
        guard let router = injector.getObject(from: .notes, type: NotesRouter.self) else { return }
        
        let viewModel = viewModel(router)
        let view = view()
        let viewController = NotesViewController(viewModel: viewModel, view: view)
        
        router.sendEvent(.inject(viewController: viewController))
        injector.addObject(to: .notes, value: viewController)
    }

}

// MARK: Public
extension NotesBuilder {
        
    func viewModel(_ router: NotesRouterProtocol) -> NotesViewModel {
        NotesViewModel(router: router)
    }
    
    func view() -> NotesView {
        NotesView()
    }
    
}

// MARK: NotesBuilderProtocol
extension NotesBuilder {
    
    var router: NotesRouterProtocol? {
        injector.getObject(from: .notes, type: NotesRouter.self)
    }
    
    var controller: NotesViewController? {
        injector.getObject(from: .notes, type: NotesViewController.self)
    }
    
}

// MARK: NotesBuilderRoutProtocol
extension NotesBuilder: NotesBuilderRoutProtocol {
    
    var window: UIWindow? {
        injector.getObject(from: .application, type: UIWindow.self)
    }
    
}
