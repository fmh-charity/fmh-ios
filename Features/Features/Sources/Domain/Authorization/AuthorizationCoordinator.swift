
import Authorization
import Coordinating

final class AuthorizationCoordinator: CoordinatorProtocol {
    
    // Dependencies
    private let router: RouterProtocol
    private var dependencies: AuthenticationDependencies
    
    // Public
    var onCompletion: (() -> Void)?
    
    private lazy var featureAssembly: AuthenticationAssemblyProtocol = {
        AuthenticationAssembly(dependencies: dependencies)
    }()
    
    // MARK: - Life cycle
    
    init(router: RouterProtocol, dependencies: AuthenticationDependencies) {
        self.router = router
        self.dependencies = dependencies
    }
    
    // MARK: CoordinatorProtocol
    
    func startFlow() {
        dependencies.onCompletion = { [weak self] in self?.onCompletion?() }
        let authenticationViewController = featureAssembly.authenticationViewController
        router.rootNavigationController(nil)
        router.setViewControllers([authenticationViewController], animated: true)
        // TODO: Добавить кастомную анимацию появления!
    }
}
