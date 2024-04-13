import Foundation
import GoogleSignIn
import SnapKit

class AuthorizationView: UIView, AuthorizationViewProtocol {
    
    var action: (() -> Void)?
    
    private let logoImageView: UIImageView
    private let labelGreeting: UILabel
    private let loginButton: UIButton
    
    init(logoImageView: UIImageView, label: UILabel, loginButton: UIButton) {
        self.logoImageView = logoImageView
        self.labelGreeting = label
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
        addSubview(logoImageView)
        addSubview(labelGreeting)
        addSubview(loginButton)
        setupLogoImageViewConstraints()
        setupLabelGreetingConstraints()
        setupLoginButtonConstraints()
    }
    
    func setupLoginButton(_ image: UIImage?) {
        loginButton.setImage(image, for: .normal)
        loginButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc func tapButton() {
        action?()
    }
    
    func setupLabelGreeting(_ text: String) {
        labelGreeting.text = text
        labelGreeting.textColor = UIColor(red: 64/255, green: 86/255, blue: 115/255, alpha: 1)
        labelGreeting.numberOfLines = 0
        labelGreeting.textAlignment = .center
        labelGreeting.font = UIFont(name: "MerriweatherSans-Regular", size: 20)
    }
    
    func setupLogoImageViewConstraints() {
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(210)
            $0.top.equalTo(safeAreaLayoutGuide).offset(80)
        }
    }
    
    func setupLabelGreetingConstraints() {
        labelGreeting.snp.makeConstraints {
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
            case .imageLogo(let image):
                logoImageView.image = image
            
            case .message(let message):
                print(message)
            
            case .imageLoginButton(let image):
                setupLoginButton(image)
            
            case .textLabelGreeting(let text):
                setupLabelGreeting(text)
        }
    }

}

// MARK: - AuthorizationViewInternalEvent
enum AuthorizationViewInternalEvent {
    case imageLogo(_ image: UIImage?)
    case message(_ message: String)
    case imageLoginButton(_ image: UIImage?)
    case textLabelGreeting(_ text: String)
}
