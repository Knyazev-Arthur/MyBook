import Foundation

protocol InjectorProtocol {
    func addObject<T>(to: InjectorContainerKey, value: T)
    func getObject<T>(from: InjectorContainerKey, type: T.Type) -> T?
    func removeContainer(_ key: InjectorContainerKey)
}
