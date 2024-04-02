import Foundation

final class Injector: InjectorProtocol {
    
    private var containers = [InjectorContainer : Any]()
    
    func addObject<T>(to key: InjectorContainer, value: T) {
        containers[key] = value
    }
    
    func getObject<T>(from key: InjectorContainer, type: T.Type) -> T? {
        containers[key] as? T
    }
    
    func removeContainer(_ key: InjectorContainer) {
        guard key != .application else { return }
        containers[key] = nil
    }
    
}

// MARK: - InjectorContainer
enum InjectorContainer: Hashable {
    case application
    case splash
    case authorization
    case menu
}
