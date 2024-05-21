import Foundation
import Combine

extension Publisher {
    
    func sink(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        sink { completion in
            switch completion {
                case .failure(let error):
                    result(.failure(error))
                case .finished:
                    break
            }
        } receiveValue: { value in
            result(.success(value))
        }
    }
    
}
