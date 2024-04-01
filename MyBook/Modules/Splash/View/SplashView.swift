import UIKit

class SplashView: UIView, SplashViewProtocol {
    
    var action: (() -> Void)?
    private let imageView: UIImageView
    
    init(imageView: UIImageView) {
        self.imageView = imageView
        super.init(frame: .zero)
        setupSplashScreenView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sendEvent(_ image: UIImage) {
        imageView.image = image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        action?()
    }
    
}

private extension SplashView {
    
    func setupSplashScreenView() {
        backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1.0)
        addSubview(imageView)
        setupImageViewConstraints()
    }
    
    func setupImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        let centerY = imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20)
        let width = imageView.widthAnchor.constraint(equalToConstant: 200)
        let height = imageView.heightAnchor.constraint(equalToConstant: 140)
        
        NSLayoutConstraint.activate([centerX, centerY, width, height])
    }
    
}
