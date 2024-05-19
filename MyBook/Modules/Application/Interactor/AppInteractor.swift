import Foundation
import Combine

class AppInteractor: AppInteractorProtocol {
    
    let externalEventPublisher: AnyPublisher<AppInteractorExternalEvent, Never>
    
    private let userLogin: AppUserLoginProtocol
    private let externalDataPublisher: PassthroughSubject<AppInteractorExternalEvent, Never>
    private var subscriptions: Set<AnyCancellable>
    
    init(userLogin: AppUserLoginProtocol) {
        self.userLogin = userLogin
        self.externalDataPublisher = PassthroughSubject<AppInteractorExternalEvent, Never>()
        self.externalEventPublisher = AnyPublisher(externalDataPublisher)
        self.subscriptions = Set<AnyCancellable>()
        setupObservers()
    }
    
    func restorePreviousSignIn() {
        userLogin.internalEventPublisher.send(.restorePreviousSignIn)
    }

}

// MARK: Private
private extension AppInteractor {
    
    func setupObservers() {
        userLogin.externalEventPublisher.sink { [weak self] in
            self?.externalEventHadler($0)
        }.store(in: &subscriptions)
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
