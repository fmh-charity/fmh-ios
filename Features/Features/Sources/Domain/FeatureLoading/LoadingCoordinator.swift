
import FeatureLoading
import Coordinating

final class LoadingCoordinator: CoordinatorProtocol {
    
    // Dependencies
    private let router: RouterProtocol
    private var dependencies: FeatureDependencies
    
    // Public
    var onCompletion: (() -> Void)?
    
    private lazy var featureAssembly: FeatureAssemblyProtocol = {
        FeatureAssembly(dependencies: dependencies)
    }()
    
    // MARK: - Life cycle
    
    init(router: RouterProtocol, dependencies: FeatureDependencies) {
        self.router = router
        self.dependencies = dependencies
    }
    
    // MARK: CoordinatorProtocol
    
    func startFlow() {
        dependencies.onCompletion = { [weak self] in self?.onCompletion?() }
        let loadingViewController = featureAssembly.loadingViewController
        router.rootViewController(loadingViewController)
    }
}
