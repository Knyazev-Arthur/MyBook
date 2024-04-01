import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var builder: AppBuilderProtocol!
    private var interactor: AppInteractorProtocol!
    private var coordinator: AppCoordinatorProtocol!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        builder = AppBuilder()
        interactor = builder.interactor
        coordinator = builder.coordinator
        guard let coordinator else { return false }
        return coordinator.start(window)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        GIDSignIn.sharedInstance.handle(url)
    }
    
}
