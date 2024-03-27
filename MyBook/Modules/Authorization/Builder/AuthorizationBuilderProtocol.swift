import Foundation

protocol AuthorizationBuilderProtocol {
    var controller: AuthorizationViewController? { get }
    var router: AuthorizationRouterProtocol? { get }
}
