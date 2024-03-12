import UIKit
import GoogleSignIn

class MyView: UIView, MyViewProtocol {
    
    weak var viewController: ViewController?
    private let gLoginButton: GIDSignInButton
    
    init() {
        gLoginButton = GIDSignInButton()
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
        addSubview(gLoginButton)
        setupGLoginButtonConstraints()
    }
    
    func setupGLoginButton() {
        gLoginButton.colorScheme = .dark
        gLoginButton.style = .wide
        gLoginButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc func tapButton() {
        guard let vc = viewController else { return }
        
        // метод инициации процесса входа пользователя через Google
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { signInResult, error in
            guard error == nil else {
                print("Ошибка входа через Google: \(error!.localizedDescription)")
                return
            }
            
            guard let signInResult else { return }

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
