import Foundation

protocol AppBuilderProtocol {
    var interactor: AppInteractorProtocol? { get }
    var coordinator: AppCoordinatorProtocol? { get }
    var splashBuilder: SplashBuilderProtocol? { get }
    var authorizationBuilder: AuthorizationBuilderProtocol? { get }
}
