import Foundation

final class AnyPublisher<T> {
    
    private weak var dataPublisher: DataPublisher<T>?
    
    init(dataPublisher: DataPublisher<T>) {
        self.dataPublisher = dataPublisher
    }
    
    func sink(_ closure: @escaping (T) -> Void) {
        dataPublisher?.sink(closure)
    }
    
}
