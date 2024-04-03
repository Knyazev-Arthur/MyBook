import Foundation

final class Container {
    
    private var objects = [String : Any]()
    
    func add<T>(value: T) {
        let key = "\(T.self)"
        objects[key] = value
    }
    
    func get<T>(type: T.Type) -> T? {
        let key = "\(T.self)"
        return objects[key] as? T
    }
    
}
