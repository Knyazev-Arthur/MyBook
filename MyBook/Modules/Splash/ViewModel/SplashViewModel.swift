import UIKit
import Combine

class SplashViewModel: SplashViewModelProtocol {
    
    let publisher: AnyPublisher<UIImage?, Never>
    
    private weak var router: SplashRouterProtocol?
    private let internalPublisher: PassthroughSubject<UIImage?, Never>
    
    init(router: SplashRouterProtocol?) {
        self.router = router
        self.internalPublisher = PassthroughSubject<UIImage?, Never>()
        self.publisher = AnyPublisher(internalPublisher)
    }
    
    func sendLogoAndAction() {
        let image = UIImage(named: "Logo")
        internalPublisher.send(image)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.router?.internalEventPublisher.send(.action)
        }
    }
    
}
