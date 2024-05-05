import Foundation

protocol MenuBuilderProtocol {
    var router: MenuRouterProtocol? { get }
    var controller: MenuTabBarController? { get }
    var mainBuilder: MainBuilderProtocol? { get }
    var favoritesBuilder: FavoritesBuilderProtocol? { get }
    var notesBuilder: NotesBuilderProtocol? { get }
    var settingsBuilder: SettingsBuilderProtocol? { get }
}
