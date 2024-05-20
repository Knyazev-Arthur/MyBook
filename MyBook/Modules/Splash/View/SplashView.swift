import UIKit
import SnapKit

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
    
    func setLogo(_ image: UIImage?) {
        logoImageView.image = image
    }
    
}

// MARK: Private
private extension SplashView {
    
    func setupConfiguration() {
        setupLayout()
        setupConstraints()
    }
    
    func setupLayout() {
        backgroundColor = .lightBeige
        addSubview(logoImageView)
    }
    
    func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(210)
        }
    }
    
}
