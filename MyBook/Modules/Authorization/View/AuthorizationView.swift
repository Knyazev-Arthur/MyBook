import SnapKit
import UIKit
import Combine

class AuthorizationView: UIView, AuthorizationViewProtocol {
    
    let publisher: AnyPublisher<Void, Never>
    
    private let externalDataPublisher: PassthroughSubject<Void, Never>
    private let logoImageView: UIImageView
    private let labelGreeting: UILabel
    private let loginButton: ProjectButtonProtocol
    private var subscriptions: Set<AnyCancellable>
    
    init(logoImageView: UIImageView, label: UILabel, loginButton: ProjectButtonProtocol) {
        self.logoImageView = logoImageView
        self.labelGreeting = label
        self.loginButton = loginButton
        self.externalDataPublisher = PassthroughSubject<Void, Never>()
        self.publisher = AnyPublisher(externalDataPublisher)
        self.subscriptions = Set<AnyCancellable>()
        super.init(frame: .zero)
        setupObservers()
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewData(_ data: AuthorizationViewData) {
        logoImageView.image = data.imageLogo
        setupLoginButton(data.imageLoginButton)
        setupLabelGreeting(data.textLabelGreeting)
    }
    
}

// MARK: Private
private extension AuthorizationView {
    
    func setupObservers() {
        loginButton.publisher.sink { [weak self] in
            self?.externalDataPublisher.send()
        }.store(in: &subscriptions)
    }
    
    func setupConfiguration() {
        setupLayout()
        setupLogoImageViewConstraints()
        setupLabelGreetingConstraints()
        setupLoginButtonConstraints()
    }
    
    func setupLayout() {
        backgroundColor = .lightBeige
        addSubview(logoImageView)
        addSubview(labelGreeting)
        addSubview(loginButton)
    }
    
    func setupLoginButton(_ image: UIImage?) {
        loginButton.setImage(image, for: .normal)
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

}

// MARK: - AuthorizationViewData
struct AuthorizationViewData {
    let imageLogo: UIImage?
    let imageLoginButton: UIImage?
    let textLabelGreeting: String
}
