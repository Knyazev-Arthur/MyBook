import Foundation

class AppInteractor: AppInteractorProtocol {
    
    let externalEvent: AnyPublisher<AppInteractorExternalEvent>
    
    private let externalDataPublisher: DataPublisher<AppInteractorExternalEvent>
    private let userLogin: AppUserLoginProtocol
    
    init(userLogin: AppUserLoginProtocol) {
        self.userLogin = userLogin
        self.externalDataPublisher = DataPublisher()
        self.externalEvent = AnyPublisher(externalDataPublisher)
        setupObservers()
    }
    
    func restorePreviousSignIn() {
        userLogin.internalEvent.send(.restorePreviousSignIn)
    }

}

// MARK: Private
private extension AppInteractor {
    
    func setupObservers() {
        userLogin.externalEvent.sink { [weak self] in
            self?.externalEventHadler($0)
        }
    }
    
    func externalEventHadler(_ event: Result<String, Error>) {
        switch event {
            case .success(_):
                externalDataPublisher.send(.authorization(.avaliable))
                
            case .failure(_):
                externalDataPublisher.send(.authorization(.unavaliable))
        }
    }
    
}

// MARK: - AppInteractorExternalEvent
enum AppInteractorExternalEvent {
    case authorization(AppUserLoginStatus)
    case pushNotitication([String : Any])
}
