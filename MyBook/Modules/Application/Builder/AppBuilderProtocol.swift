import Foundation
import UIKit

protocol AppBuilderProtocol {
    var window: UIWindow? { get }
    var interactor: AppInteractorProtocol? { get }
    var coordinator: AppCoordinatorProtocol? { get }
    var splashBuilder: SplashBuilderProtocol? { get }
    var authorizationBuilder: AuthorizationBuilderProtocol? { get }
    var menuBuilder: MenuBuilderProtocol? { get }
}
