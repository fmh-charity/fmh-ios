
import UIKit

public final class TabBarControllerAssembly {
    
    private let dependencies: TabBarControllerDependencies
    
    public init(dependencies: TabBarControllerDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - TabBarControllerAssemblyProtocol

extension TabBarControllerAssembly: TabBarControllerAssemblyProtocol {
    
    public var tabBarController: UITabBarController {
        let controller = TabBarController()
        controller.setViewControllers(dependencies.viewControllers, animated: false)
        return controller
    }
}
