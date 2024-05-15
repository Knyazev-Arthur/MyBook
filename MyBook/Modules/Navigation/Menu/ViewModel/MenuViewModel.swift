import Foundation

class MenuViewModel: MenuViewModelProtocol {
    
    let externalEvent: AnyPublisher<Void>
    
    private let externalDataPublisher: DataPublisher<Void>
    private weak var router: MenuRouterProtocol?
    
    init(router: MenuRouterProtocol?) {
        self.router = router
        self.externalDataPublisher = DataPublisher()
        self.externalEvent = AnyPublisher(externalDataPublisher)
    }
        
}
