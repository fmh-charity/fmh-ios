
import UIKit

public final class TabBarWithMenuControllerAssembly {
    
    private let dependencies: TabBarWithMenuControllerDependencies
    
    public init(dependencies: TabBarWithMenuControllerDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - TabBarWithMenuControllerAssemblyProtocol

extension TabBarWithMenuControllerAssembly: TabBarWithMenuControllerAssemblyProtocol {
    
    public var tabBarWithMenu: UIViewController {
        
        let sideMenuViewController = SideMenuViewController()
        sideMenuViewController.isHighlightedCellOff = false
        sideMenuViewController.sections = dependencies.sideMenuSectionItems
        
        let tabBarController = TabBarController(viewControllers: dependencies.viewControllers)
        let menuViewPresenter = MenuViewPresenter(networkService: dependencies.network)
        
        let menuViewController = MenuViewController(
            presenter: menuViewPresenter,
            sideMenuViewController: sideMenuViewController,
            containerViewController: tabBarController
        )
        
        tabBarController.handlerActionsMenu = menuViewController
        
        return menuViewController
    }
}
