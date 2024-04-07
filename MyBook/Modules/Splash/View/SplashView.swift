import Foundation
import UIKit

class SplashView: UIView, SplashViewProtocol {
    
    private let logoImageView: UIImageView
    
    init(imageView: UIImageView) {
        self.logoImageView = imageView
        super.init(frame: .zero)
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sendEvent(_ image: UIImage?) {
        logoImageView.image = image
    }
    
}

// MARK: Private
private extension SplashView {
    
    func setupConfiguration() {
        backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1.0)
        addSubview(logoImageView)
        setupConstraints()
    }
    
    func setupConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        let centerY = logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20)
        let width = logoImageView.widthAnchor.constraint(equalToConstant: 200)
        let height = logoImageView.heightAnchor.constraint(equalToConstant: 140)
        
        NSLayoutConstraint.activate([centerX, centerY, width, height])
    }
    
}
