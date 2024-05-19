import UIKit
import Combine

class SplashViewModel: SplashViewModelProtocol {
    
    let externalEventPublisher: AnyPublisher<UIImage?, Never>
    
    private weak var router: SplashRouterProtocol?
    private let externalDataPublisher: PassthroughSubject<UIImage?, Never>
    
    init(router: SplashRouterProtocol?) {
        self.router = router
        self.externalDataPublisher = PassthroughSubject<UIImage?, Never>()
        self.externalEventPublisher = AnyPublisher(externalDataPublisher)
    }
    
    func sendLogoAndAction() {
        let image = UIImage(named: "Logo")
        externalDataPublisher.send(image)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.router?.internalEventPublisher.send(.action)
        }
    }
    
}
