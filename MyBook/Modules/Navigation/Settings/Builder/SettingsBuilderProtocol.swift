import Foundation

protocol SettingsBuilderProtocol: AnyObject {
    var router: SettingsRouterProtocol? { get }
    var controller: SettingsViewController? { get }
}
