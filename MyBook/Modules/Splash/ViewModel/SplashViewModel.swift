import Foundation

class SplashViewModel: SplashViewModelProtocol {
    
    var action: ((Data) -> Void)?
    
    private let logoImage: SplashLogoImageProtocol
    
    init(logoImage: SplashLogoImageProtocol) {
        self.logoImage = logoImage
        setupObservers()
    }
    
    private func setupObservers() {
        logoImage.action = { [weak self] in
            self?.action?($0)
        }
    }
    
    func sendEvent() {
        logoImage.sendEvent()
    }
    
}
