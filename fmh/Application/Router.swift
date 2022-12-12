//
//  Router.swift
//  fmh
//
//  Created: 26.11.2022
//

import UIKit

//MARK: - Routable
protocol Routable: Presentable {
    
    func setWindowRoot(_ screen: Presentable?)
    func setRoot(_ screen: Presentable?, hideBar: Bool)
    func push(_ screen: Presentable?, animated: Bool)
    func present(_ screen: Presentable?, animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)

}

//MARK: - Presentable
protocol Presentable: AnyObject {
    var toPresent: UIViewController? { get }
}

extension Presentable where Self: UIViewController {
    var toPresent: UIViewController? { return self }
}


//MARK: - Class
final class Router: NSObject {

    //TODO: ВОЗМОЖНО ПОТОМ КОНТРОЛЬ И ЛОГИРОВАНИЕ ПЕРЕХОДОВ ...
    
    fileprivate var window: UIWindow?
    fileprivate let navigationController: UINavigationController
    
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = BaseNavigationController()
    }
    
    var toPresent: UIViewController? {
        return navigationController
    }
    
}


//MARK: - Routable
extension Router: Routable {
    
    func setWindowRoot(_ screen: Presentable?) {
        guard let controller = screen?.toPresent else { return }
        window?.rootViewController = controller
    }
    
    func setRoot(_ screen: Presentable?, hideBar: Bool) {
        guard let controller = screen?.toPresent else { return }
        navigationController.setViewControllers([controller], animated: false)
        navigationController.isNavigationBarHidden = hideBar
        window?.rootViewController = navigationController
    }
    
    func push(_ screen: Presentable?, animated: Bool) {
        guard
            let controller = screen?.toPresent, !(controller is UINavigationController) else {
            assertionFailure("Deprecated push UINavigationController.")
            return
        }
        navigationController.pushViewController(controller, animated: animated)
    }
    
    func present(_ screen: Presentable?, animated: Bool) {
        guard let controller = screen?.toPresent else { return }
        navigationController.present(controller, animated: animated, completion: nil)
    }
    
    func pop(animated: Bool)  {
         navigationController.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        navigationController.dismiss(animated: animated, completion: completion)
    }

}
