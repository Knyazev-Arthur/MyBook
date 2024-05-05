import UIKit

class TabBarAppearance: TabBarAppearanceProtocol {
    
    var action: (() -> Void)?
    
    private weak var tabBarController: MenuTabBarController?
    
    func sendEvent(_ event: TabBarAppearanceInternalEvent) {
        internalEventHadler(event)
    }
    
}

// MARK: Private
private extension TabBarAppearance {
    
    func internalEventHadler(_ event: TabBarAppearanceInternalEvent) {
        switch event {
            case .updateTabBar:
                updateTabBar()
            
            case .inject(let tabBarController):
                self.tabBarController = tabBarController
        }
    }
    
    func updateTabBar() {
        guard let tabBar = tabBarController?.tabBar else { return }
        
        tabBar.items?[0].image = UIImage(named: "Main")?.withRenderingMode(.alwaysOriginal)
        tabBar.items?[1].image = UIImage(named: "Favorites")?.withRenderingMode(.alwaysOriginal)
        tabBar.items?[2].image = UIImage(named: "Notes")?.withRenderingMode(.alwaysOriginal)
        tabBar.items?[3].image = UIImage(named: "Settings")?.withRenderingMode(.alwaysOriginal)
        
        tabBar.items?[0].selectedImage = UIImage(named: "MainSelect")?.withRenderingMode(.alwaysOriginal)
        tabBar.items?[1].selectedImage = UIImage(named: "FavoritesSelect")?.withRenderingMode(.alwaysOriginal)
        tabBar.items?[2].selectedImage = UIImage(named: "NotesSelect")?.withRenderingMode(.alwaysOriginal)
        tabBar.items?[3].selectedImage = UIImage(named: "SettingsSelect")?.withRenderingMode(.alwaysOriginal)
        
        tabBar.backgroundColor = .lightBlue
    }
    
}

// MARK: -
enum TabBarAppearanceInternalEvent {
    case inject(tabBarController: MenuTabBarController?)
    case updateTabBar
}
