
import TabBarWithMenuController
import Coordinating

final class TabBarWithMenuControllerCoordinator: CoordinatorProtocol {
    
    // Dependencies
    private let router: RouterProtocol
    private var dependencies: TabBarWithMenuControllerDependencies
    
    // Public
    var onCompletion: (() -> Void)?
    
    private lazy var assembly: TabBarWithMenuControllerAssemblyProtocol = {
        TabBarWithMenuControllerAssembly(dependencies: dependencies)
    }()
    
    // MARK: - Life cycle
    
    init(router: RouterProtocol, dependencies: TabBarWithMenuControllerDependencies) {
        self.router = router
        self.dependencies = dependencies
    }
    
    // MARK: CoordinatorProtocol
    
    func startFlow() {
        dependencies.onCompletion = { [weak self] in self?.onCompletion?() }
        let tabBarController = assembly.tabBarWithMenu
        router.rootViewController(tabBarController)
    }
}
