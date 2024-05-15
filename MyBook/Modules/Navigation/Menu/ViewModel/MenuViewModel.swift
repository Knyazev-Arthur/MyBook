import Foundation

class MenuViewModel: MenuViewModelProtocol {
    
    let externalEvent: AnyPublisher<Void>
    
    private let dataPublisher: DataPublisher<Void>
    private weak var router: MenuRouterProtocol?
    
    init(router: MenuRouterProtocol?) {
        dataPublisher = DataPublisher<Void>()
        externalEvent = AnyPublisher(dataPublisher)
        self.router = router
    }
    
    func internalEvent() {}
    
}
