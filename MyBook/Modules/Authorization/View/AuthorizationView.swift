import Foundation
import GoogleSignIn
import SnapKit

class AuthorizationView: UIView, AuthorizationViewProtocol {
    
    var action: (() -> Void)?
    
    private let logoImageView: UIImageView
    private let label: UILabel
    private let loginButton: UIButton
    
    init(logoImageView: UIImageView, label: UILabel, loginButton: UIButton) {
        self.logoImageView = logoImageView
        self.label = label
        self.loginButton = loginButton
        super.init(frame: .zero)
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sendEvent(_ event: AuthorizationViewInternalEvent) {
        internalEventHadler(event)
    }
    
}

// MARK: Private
private extension AuthorizationView {
    
    func setupConfiguration() {
        backgroundColor = .lightBeige
        setupLabel()
        setupLoginButton()
        addSubview(logoImageView)
        addSubview(label)
        addSubview(loginButton)
        setupLogoImageViewConstraints()
        setupLabelConstraints()
        setupLoginButtonConstraints()
    }
    
    func setupLoginButton() {
        let image = UIImage(named: "LoginButton")
        loginButton.setImage(image, for: .normal)
        loginButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc func tapButton() {
        action?()
    }
    
    func setupLabel() {
        label.text = NSLocalizedString("initialGreeting", comment: "")
        label.textColor = UIColor(red: 64/255, green: 86/255, blue: 115/255, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "MerriweatherSans-Regular", size: 20)
    }
    
    func setupLogoImageViewConstraints() {
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(210)
            $0.top.equalTo(safeAreaLayoutGuide).offset(80)
        }
    }
    
    func setupLabelConstraints() {
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(40)
            $0.width.equalTo(250)
            $0.height.equalTo(60)
        }
    }
    
    func setupLoginButtonConstraints() {
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(60)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-120)
        }
    }
    
    func internalEventHadler(_ event: AuthorizationViewInternalEvent) {
        switch event {
            case .logoImage(let logoImage):
                logoImageView.image = logoImage
            
            case .message(let message):
                print(message)
        }
    }

}

// MARK: - AuthorizationViewInternalEvent
enum AuthorizationViewInternalEvent {
    case logoImage(_ logoImage: UIImage?)
    case message(_ message: String)
}
