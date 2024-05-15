import Foundation

class AppInteractor: AppInteractorProtocol {
    
    let externalEvent: AnyPublisher<AppInteractorExternalEvent>
    
    private let dataPublisher: DataPublisher<AppInteractorExternalEvent>
    private let userLogin: AppUserLoginProtocol
    
    init(userLogin: AppUserLoginProtocol) {
        self.userLogin = userLogin
        self.dataPublisher = DataPublisher()
        self.externalEvent = AnyPublisher(dataPublisher)
        setupObservers()
    }
    
    func restorePreviousSignIn() {
        userLogin.internalEvent.send(.restorePreviousSignIn)
    }

}

// MARK: Private
private extension AppInteractor {
    
    private func setupObservers() {
        userLogin.externalEvent.sink { [weak self] in
            self?.externalEventHadler($0)
        }
    }
    
    func externalEventHadler(_ event: Result<String, Error>) {
        switch event {
            case .success(_):
                dataPublisher.send(.authorization(.avaliable))
                
            case .failure(_):
                dataPublisher.send(.authorization(.unavaliable))
        }
    }
    
}

// MARK: - AppInteractorExternalEvent
enum AppInteractorExternalEvent {
    case authorization(AppUserLoginStatus)
    case pushNotitication([String : Any])
}
