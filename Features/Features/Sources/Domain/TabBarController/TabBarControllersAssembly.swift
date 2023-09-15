import UIKit
import Home

protocol TabBarControllersAssemblyProtocol {
    var viewControllers: [UIViewController] { get }
}

class TabBarControllersAssembly {
    
    // Dependencies
    private let dependencies: FeaturesDependencies
    
    // MARK: - Life cycle
    
    public init(dependencies: FeaturesDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - TabBarControllersAssemblyProtocol

extension TabBarControllersAssembly: TabBarControllersAssemblyProtocol {
    
    /// Контроллеры для вкладок снизу.
    var viewControllers: [UIViewController]  {
        
        // MARK: Tab 1
        let controllerTab_1 = NavigationController(rootViewController: homeController)
        controllerTab_1.tabBarItem.tag = 1
        controllerTab_1.tabBarItem.image = UIImage(systemName: "house.fill")
        controllerTab_1.tabBarItem.title = controllerTab_1.title ?? "Главная"
        
        // MARK: Tab 2
        let controllerTab_2 = NavigationController(rootViewController: makeTestViewController(title: "Просьбы"))
        controllerTab_2.tabBarItem.tag = 2
        controllerTab_2.tabBarItem.image = UIImage(systemName: "heart.fill")
        controllerTab_2.tabBarItem.title = controllerTab_1.title ?? "Просьбы"
        
        // MARK: Tab 3
        let controllerTab_3 = NavigationController(rootViewController: makeTestViewController(title: "Пациенты"))
        controllerTab_3.tabBarItem.tag = 3
        controllerTab_3.tabBarItem.image = UIImage(named: "bar.patients", in: .module, with: .none)
        controllerTab_3.tabBarItem.title = controllerTab_1.title ?? "Пациенты"
        
        // MARK: Tab 4
        let controllerTab_4 = NavigationController(rootViewController: makeTestViewController(title: "Ещё"))
        controllerTab_4.tabBarItem.tag = 4
        controllerTab_4.tabBarItem.image = UIImage(systemName: "line.3.horizontal")
        controllerTab_4.tabBarItem.title = controllerTab_1.title ?? "Ещё"
        
        return [controllerTab_1, controllerTab_2, controllerTab_3, controllerTab_4]
    }
}

// MARK: - ViewControllers assembly

private extension TabBarControllersAssembly {
    
    var homeController: UIViewController {
        HomeAssembly(
            dependencies: .init()
        ).homeViewController
    }
}

// MARK: Temp
private func makeTestViewController(title: String?) -> UIViewController {
    let controller = UIViewController()
    controller.title = title
    controller.view.backgroundColor = .systemBackground
    return controller
}
