import Foundation

class AppInteractor: AppInteractorProtocol {
    
    let externalEvent: AnyPublisher <AppInteractorExternalEvent>
    
    private let dataPublisher: DataPublisher<AppInteractorExternalEvent>
    private let userLogin: AppUserLoginProtocol
    
    init(userLogin: AppUserLoginProtocol) {
        dataPublisher = DataPublisher<AppInteractorExternalEvent>()
        externalEvent = AnyPublisher(dataPublisher)
        self.userLogin = userLogin
        setupObservers()
    }
    
    func restorePreviousSignIn() {
        userLogin.internalEvent.send(.restorePreviousSignIn)
    }

}

// MARK: Private
private extension AppInteractor {
    
    private func setupObservers() {
        userLogin.externalEvent.sink { [weak self] event in
            self?.externalEventHadler(event)
        }
    }
    
    func externalEventHadler(_ event: Result<String, Error>?) {
        switch event {
            case .success(_):
                dataPublisher.send(.authorization(.avaliable))
                
            case .failure(_):
                dataPublisher.send(.authorization(.unavaliable))
            
            case .none:
                break
        }
    }
    
}

// MARK: - AppInteractorExternalEvent
enum AppInteractorExternalEvent {
    case authorization(UserLoginStatus)
    case pushNotitication([String : Any])
}

// MARK: - UserLoginStatus
enum UserLoginStatus {
    case unavaliable
    case avaliable
}
