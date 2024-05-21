import Foundation
import Combine

extension Subject {
    
    func send(_ error: Failure) {
        send(completion: .failure(error))
    }
    
}
