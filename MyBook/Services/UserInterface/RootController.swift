import UIKit

struct RootController {
    
    static func setRootViewController(_ window: UIWindow?,_ viewController: UIViewController?) {
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 0.4
        window?.layer.add(transition, forKey: "transition")
        window?.rootViewController = viewController
    }
    
    static func setRootNavigationController(_ window: UIWindow?,_ navigationController: UIViewController?) {
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 0.4
        window?.layer.add(transition, forKey: "transition")
        window?.rootViewController = navigationController
    }
    
}
