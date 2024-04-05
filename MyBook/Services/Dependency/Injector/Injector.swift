import Foundation

final class Injector: InjectorProtocol {
    
    private var containers = [InjectorContainerKey : Container]()
    
    func addObject<T>(to key: InjectorContainerKey, value: T) {
        guard containers[key] != nil else {
            containers[key] = Container()
            containers[key]?.add(value: value)
            return
        }
        
        containers[key]?.add(value: value)
    }
    
    func getObject<T>(from key: InjectorContainerKey, type: T.Type) -> T? {
        guard let container = containers[key], let object = container.get(type: type) else {
            print("⛔️ Error of getting object with type: \(type) from container: \(key) ❗️")
            return nil
        }
        
        return object
    }
    
    func removeContainer(_ key: InjectorContainerKey) {
        guard key != .application else { return }
        containers[key] = nil
    }
    
}

// MARK: - InjectorContainerKey
enum InjectorContainerKey: Hashable {
    case application
    case splash
    case authorization
    case menu
}
