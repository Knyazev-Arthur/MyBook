import GoogleSignIn

class AppUserLogin: AppUserLoginProtocol {
    
    var action: ((GIDGoogleUser?) -> Void)?
    
    private let googleService: GIDSignIn
    
    init(googleService: GIDSignIn) {
        self.googleService = googleService
    }
    
    func sendEvent() {
        googleService.restorePreviousSignIn { [weak self] user, _ in
            self?.action?(user)
        }
    }
    
}
