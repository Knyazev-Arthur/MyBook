import Foundation
import Combine

extension Subject {
    
    func send(_ result: Result<Output, Failure>) {
        switch result {
            case .failure(let error):
                send(completion: .failure(error))
            
            case .success(let value):
                send(value)
        }
    }
    
}
