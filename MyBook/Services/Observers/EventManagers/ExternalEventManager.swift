import Foundation

final class ExternalEventManager<T>  {
    
    private var subscriptions = [((T) -> Void)?]()
    
    func addSubscription(_ closure: @escaping (T) -> Void) {
        subscriptions.append(closure)
    }
    
    func removeSubscription() {
        subscriptions.removeAll()
    }
    
    func sendExternalEvent(_ event: T) {
        subscriptions.forEach {
            $0?(event)
        }
    }
    
}
