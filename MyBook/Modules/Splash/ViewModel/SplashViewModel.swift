import UIKit
import Combine

class SplashViewModel: SplashViewModelProtocol {
    
    private weak var router: SplashRouterProtocol?
    
    let publisher: AnyPublisher<UIImage?, Never>
    
    private let externalDataPublisher: PassthroughSubject<UIImage?, Never>
    
    init(router: SplashRouterProtocol?) {
        self.router = router
        self.externalDataPublisher = PassthroughSubject<UIImage?, Never>()
        self.publisher = AnyPublisher(externalDataPublisher)
    }
    
    func sendLogoAndAction() {
        let image = UIImage(named: "Logo")
        externalDataPublisher.send(image)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.router?.internalEventPublisher.send(.action)
        }
    }
    
}
