import Foundation

class SplashBuilder: SplashBuilderProtocol {
    
    private let injector: InjectorProtocol
    
    init(injector: InjectorProtocol) {
        self.injector = injector
    }
    
}
