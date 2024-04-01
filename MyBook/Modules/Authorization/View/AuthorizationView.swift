import GoogleSignIn

class AuthorizationView: UIView, AuthorizationViewProtocol {
    
    var action: (() -> Void)?
    
    private let label: UILabel
    private let loginButton: GIDSignInButton
    
    init(label: UILabel, loginButton: GIDSignInButton) {
        self.label = label
        self.loginButton = loginButton
        super.init(frame: .zero)
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sendEvent(_ message: String) {
        print(message)
    }
    
}

// MARK: Private
private extension AuthorizationView {
    
    func setupConfiguration() {
        backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1.0)
        setupLoginButton()
        setupLabel()
        addSubview(loginButton)
        addSubview(label)
        setupLabelConstraints()
        setupGLoginButtonConstraints()
    }
    
    func setupLoginButton() {
        loginButton.colorScheme = .dark
        loginButton.style = .wide
        loginButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc func tapButton() {
        action?()
    }
    
    func setupLabel() {
        label.text = NSLocalizedString("initialGreeting", comment: "")
        label.numberOfLines = 0
        label.textAlignment = .center
    }
    
    func setupLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = label.centerXAnchor.constraint(equalTo: centerXAnchor)
        let centerY = label.centerYAnchor.constraint(equalTo: centerYAnchor)
        let height = label.heightAnchor.constraint(equalToConstant: 50)
        let width = label.widthAnchor.constraint(equalToConstant: 250)
        
        NSLayoutConstraint.activate([centerX, centerY, height, width])
    }
    
    func setupGLoginButtonConstraints() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = loginButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        let bottom = loginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -25)
        let height = loginButton.heightAnchor.constraint(equalToConstant: 70)
        let width = loginButton.widthAnchor.constraint(equalToConstant: 200)
        
        NSLayoutConstraint.activate([centerX, bottom, height, width])
    }

}
