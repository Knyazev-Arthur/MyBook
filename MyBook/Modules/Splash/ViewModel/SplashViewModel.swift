import UIKit

class SplashViewModel: SplashViewModelProtocol {
    
    let externalEvent: AnyPublisher<UIImage?>
    
    private weak var router: SplashRouterProtocol?
    private let dataPublisher: DataPublisher<UIImage?>
    
    init(router: SplashRouterProtocol?) {
        self.router = router
        self.dataPublisher = DataPublisher()
        self.externalEvent = AnyPublisher(dataPublisher)
    }
    
    func sendLogoAndAction() {
        let image = UIImage(named: "Logo")
        dataPublisher.send(image)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.router?.internalEvent.send(.action)
        }
    }
    
}
