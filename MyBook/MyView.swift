import UIKit
import GoogleSignIn

class MyView: UIView, MyViewProtocol {
    
    weak var viewController: ViewController?
    private let gLoginButton: GIDSignInButton
    private let label: UILabel
    
    init() {
        gLoginButton = GIDSignInButton()
        label = UILabel()
        super.init(frame: .zero)
        setupMyView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension MyView {
    
    func setupMyView() {
        backgroundColor = .white
        setupGLoginButton()
        setupLabel()
        addSubview(gLoginButton)
        addSubview(label)
        setupLabelConstraints()
        setupGLoginButtonConstraints()
    }
    
    func setupGLoginButton() {
        gLoginButton.colorScheme = .dark
        gLoginButton.style = .wide
        gLoginButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc func tapButton() {
        guard let vc = viewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { signInResult, error in
            guard error == nil else {
                print("Ошибка входа через Google: \(error!.localizedDescription)")
                return
            }
            guard let signInResult else { return }
            self.getUserToken(signInResult)
        }
    }
    
    func getUserToken(_ signInResult: GIDSignInResult) {
        signInResult.user.refreshTokensIfNeeded { user, error in
            guard error == nil else { return }
            guard let user else { return }

            guard let idToken = user.idToken?.tokenString else { return }
            guard let userID = user.userID else { return }
            print("Вход через Google выполнен успешно")
            print("Токен пользователя: ", idToken)
            print("id пользователя: ", userID)
        }
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
        gLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = gLoginButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        let bottom = gLoginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -25)
        let height = gLoginButton.heightAnchor.constraint(equalToConstant: 70)
        let width = gLoginButton.widthAnchor.constraint(equalToConstant: 200)
        
        NSLayoutConstraint.activate([centerX, bottom, height, width])
    }

}

// MARK: MyViewProtocol
protocol MyViewProtocol: UIView {
    var viewController: ViewController? { get set }
}
