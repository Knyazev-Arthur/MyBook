import Foundation
import Combine

class AppInteractor: AppInteractorProtocol {
    
    let publisher: AnyPublisher<AppInteractorExternalEvent, Never>
    
    private let userLogin: AppUserLoginProtocol
    private let internalPublisher: PassthroughSubject<AppInteractorExternalEvent, Never>
    private var subscriptions: Set<AnyCancellable>
    
    init(userLogin: AppUserLoginProtocol) {
        self.userLogin = userLogin
        self.internalPublisher = PassthroughSubject<AppInteractorExternalEvent, Never>()
        self.publisher = AnyPublisher(internalPublisher)
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
            self?.externalEventHandler($0)
        }.store(in: &subscriptions)
    }
    
    func externalEventHandler(_ event: Result<String, Error>) {
        switch event {
            case .success(_):
                internalPublisher.send(.authorization(.avaliable))
                
            case .failure(_):
                internalPublisher.send(.authorization(.unavaliable))
        }
    }
    
}

// MARK: - AppInteractorExternalEvent
enum AppInteractorExternalEvent {
    case authorization(AppUserLoginStatus)
    case pushNotitication([String : Any])
}
