import UIKit

class SplashViewModel: SplashViewModelProtocol {
    
    let externalEvent: AnyPublisher<UIImage?>
    
    private weak var router: SplashRouterProtocol?
    private let externalDataPublisher: DataPublisher<UIImage?>
    
    init(router: SplashRouterProtocol?) {
        self.router = router
        self.externalDataPublisher = DataPublisher()
        self.externalEvent = AnyPublisher(externalDataPublisher)
    }
    
    func sendLogoAndAction() {
        let image = UIImage(named: "Logo")
        externalDataPublisher.send(image)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.router?.internalEvent.send(.action)
        }
    }
    
}
