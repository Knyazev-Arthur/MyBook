import UIKit

class SettingsBuilder: SettingsBuilderProtocol {
    
    private let injector: InjectorProtocol
    
    init(injector: InjectorProtocol) {
        self.injector = injector
    }

}

// MARK: Private
private extension SettingsBuilder {
    
    func register() {
        screenRouter()
        viewController()
    }
    
    func screenRouter() {
        let router = SettingsRouter(builder: self)
        injector.addObject(to: .settings, value: router)
    }
    
    func viewController() {
        guard let router = injector.getObject(from: .settings, type: SettingsRouter.self) else { return }
        
        let viewModel = viewModel(router)
        let view = view()
        let viewController = SettingsViewController(viewModel: viewModel, view: view)
        
        router.sendEvent(.inject(viewController: viewController))
        injector.addObject(to: .notes, value: viewController)
    }

}

// MARK: Public
extension SettingsBuilder {
        
    func viewModel(_ router: SettingsRouterProtocol) -> SettingsViewModel {
        SettingsViewModel(router: router)
    }
    
    func view() -> SettingsView {
        SettingsView()
    }
    
}

// MARK: NotesBuilderProtocol
extension SettingsBuilder {
    
    var router: SettingsRouterProtocol? {
        injector.getObject(from: .notes, type: SettingsRouter.self)
    }
    
    var controller: SettingsViewController? {
        injector.getObject(from: .notes, type: SettingsViewController.self)
    }
    
}

// MARK: SettingsBuilderRoutProtocol
extension SettingsBuilder: SettingsBuilderRoutProtocol {
    
    var window: UIWindow? {
        injector.getObject(from: .application, type: UIWindow.self)
    }
    
}
