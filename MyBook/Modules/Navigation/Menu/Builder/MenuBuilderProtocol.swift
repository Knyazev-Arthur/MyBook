import Foundation

protocol MenuBuilderProtocol {
    var router: MenuRouterProtocol? { get }
    var controller: MenuTabBarController? { get }
}
