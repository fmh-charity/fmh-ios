import UIKit

protocol TabBarWithMenuControllersAssemblyProtocol {
    var viewControllers: [UIViewController] { get }
}

class TabBarWithMenuControllersAssembly {
    
    // Dependencies
    private let dependencies: FeaturesDependencies
    
    // MARK: - Life cycle
    
    public init(dependencies: FeaturesDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - TabBarWithMenuControllersAssemblyProtocol

extension TabBarWithMenuControllersAssembly: TabBarWithMenuControllersAssemblyProtocol {
    
    var viewControllers: [UIViewController]  {
        [
            // Контроллеры для вкладок снизу.
        ]
    }
}
