import Foundation

final class DataPublisher<T> {
    
    private var subscriptions = [(T) -> Void]()
    
    func send(_ data: T) {
        subscriptions.forEach {
            $0(data)
        }
    }
    
    func sink(_ closure: @escaping (T) -> Void) {
        subscriptions.append(closure)
    }
    
}
