//
//  Router.swift
//  fmh
//
//  Created: 26.11.2022
//

import UIKit

// MARK: - Presentable

protocol Presentable: AnyObject {
    var toPresent: UIViewController { get }
}

extension Presentable where Self: UIViewController {
    var toPresent: UIViewController { return self }
}

// MARK: - Routable

protocol Routable {
    func getNavigationController() -> UINavigationController?
    func getRootViewController() -> UIViewController?
    func setDefaultNavigationController()
    func setNavigationController(_ navigationController: UINavigationController)
    func setWindowRoot(_ screen: Presentable?)
    func setRoot(_ screen: Presentable?, hideBar: Bool, animated: Bool)
    func push(_ screen: Presentable?, animated: Bool)
    func present(_ screen: Presentable?, animated: Bool, completion: (() -> Void)?)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

// MARK: - Class

final class Router: NSObject {

    private var window: UIWindow?
    private var navigationController: UINavigationController?
    
    init(window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
    }
}

// MARK: - Routable

extension Router: Routable {
    
    func getNavigationController() -> UINavigationController? {
        self.navigationController
    }

    func getRootViewController() -> UIViewController? {
        self.window?.rootViewController
    }
    
    func setDefaultNavigationController() {
        self.navigationController = NavigationController()
    }
    
    func setNavigationController(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setWindowRoot(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
        window?.rootViewController = navigationController
    }
    
    func setWindowRoot(_ screen: Presentable?) {
        guard let controller = screen?.toPresent else { return }
        self.navigationController = nil
        window?.rootViewController = controller
    }
    
    func setRoot(_ screen: Presentable?, hideBar: Bool, animated: Bool) {
        guard let controller = screen?.toPresent else { return }
        navigationController?.setViewControllers([controller], animated: animated)
        navigationController?.isNavigationBarHidden = hideBar
    }
    
    func push(_ screen: Presentable?, animated: Bool) {
        guard
            let controller = screen?.toPresent, !(controller is UINavigationController) else {
            assertionFailure("Deprecated push UINavigationController.")
            return
        }
        navigationController?.pushViewController(controller, animated: animated)
    }
    
    func present(_ screen: Presentable?, animated: Bool, completion: (() -> Void)?) {
        guard let controller = screen?.toPresent else { return }
        navigationController?.present(controller, animated: animated, completion: completion)
    }
    
    func pop(animated: Bool)  {
         navigationController?.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }
}
