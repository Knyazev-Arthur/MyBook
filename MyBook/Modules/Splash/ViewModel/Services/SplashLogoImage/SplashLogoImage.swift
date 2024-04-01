import UIKit

class SplashLogoImage: SplashLogoImageProtocol {
    
    var action: ((Data) -> Void)?
    
    func sendEvent() {
        guard let image = UIImage(named: "logo"), let data = image.pngData() else {
            print("Error: No image")
            return
        }
        action?(data)
    }
    
}

