
import TabBarController
import Coordinating

final class TabBarControllerCoordinator: CoordinatorProtocol {
    
    // Dependencies
    private let router: RouterProtocol
    private var dependencies: TabBarControllerDependencies
    
    // Public
    var onCompletion: (() -> Void)?
    
    private lazy var assembly: TabBarControllerAssemblyProtocol = {
        TabBarControllerAssembly(dependencies: dependencies)
    }()
    
    // MARK: - Life cycle
    
    init(router: RouterProtocol, dependencies: TabBarControllerDependencies) {
        self.router = router
        self.dependencies = dependencies
    }
    
    // MARK: CoordinatorProtocol
    
    func startFlow() {
        dependencies.onCompletion = { [weak self] in self?.onCompletion?() }
        let tabBarController = assembly.tabBarController
        router.rootViewController(tabBarController)
    }
}
