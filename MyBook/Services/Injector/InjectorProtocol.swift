import Foundation

protocol InjectorProtocol {
    func addObject<T>(to: InjectorContainer, value: T)
    func getObject<T>(from: InjectorContainer, type: T.Type) -> T?
    func removeContainer(_ key: InjectorContainer)
}
