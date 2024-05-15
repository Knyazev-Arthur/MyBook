import Foundation

final class AnyPublisher<T> {
    
    private weak var dataPublisher: DataPublisher<T>?
    
    init(_ dataPublisher: DataPublisher<T>) {
        self.dataPublisher = dataPublisher
    }
    
    func sink(_ closure: @escaping (T?) -> Void) {
        dataPublisher?.sink(closure)
    }
    
}
