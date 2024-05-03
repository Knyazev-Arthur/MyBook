import Foundation

class NotesViewModel: NotesViewModelProtocol {
    
    var action: (() -> Void)?
    
    private weak var router: NotesRouterProtocol?
    
    init(router: NotesRouterProtocol?) {
        self.router = router
    }
    
    func sendEvent() {}
    
}
