import Foundation

protocol MainBuilderProtocol {
    var router: MainRouterProtocol? { get }
    var controller: MainNavigationController? { get }
}
