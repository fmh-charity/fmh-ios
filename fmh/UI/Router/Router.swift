//
//  Router.swift
//  fmh
//
//  Created: 26.11.2022
//

import UIKit

final class Router: NSObject {
    
    private var window: UIWindow?
    private var navigationController: UINavigationController?
    
    init(window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
    }
}

// MARK: - RouterProtocol

extension Router: RouterProtocol {
    
    func getWindowRootController() -> UIViewController? {
        self.window?.rootViewController
    }
    
    func setWindowRootController(with controller: UIViewController?) {
        guard let controller else { return }
        window?.rootViewController = controller
    }
    
    func setWindowRootNavigationController() {
        window?.rootViewController = navigationController
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
