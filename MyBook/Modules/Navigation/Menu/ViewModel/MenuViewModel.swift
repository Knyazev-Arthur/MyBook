import Foundation

class MenuViewModel: MenuViewModelProtocol {
    
    let externalEvent: AnyPublisher<Void>
    
    private let dataPublisher: DataPublisher<Void>
    private weak var router: MenuRouterProtocol?
    
    init(router: MenuRouterProtocol?) {
        self.router = router
        self.dataPublisher = DataPublisher()
        self.externalEvent = AnyPublisher(dataPublisher)
    }
        
}
