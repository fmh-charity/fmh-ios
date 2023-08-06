//
//  RoutingProvider.swift
//  fmh
//
//  Created: 01.08.2023
//

import UIKit

public final class RoutingProvider {
    
    private weak var window: UIWindow?
    private weak var navigationController: UINavigationController?
    
    public init(window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
    }
}

// MARK: - Routable

extension RoutingProvider: Routing {
    
    public var topViewController: UIViewController? {
        navigationController?.topViewController
    }
    
    public var visibleViewController: UIViewController? {
        navigationController?.visibleViewController
    }
    
    public var viewControllers: [UIViewController] {
        navigationController?.viewControllers ?? []
    }
    
    
    public func setRootViewController(_ viewController: UIViewController?) {
        window?.rootViewController = viewController
    }
    
    public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    public func popViewController(animated: Bool) -> UIViewController? {
        navigationController?.popViewController(animated: animated)
    }
    
    public func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        navigationController?.popToViewController(viewController, animated: animated)
    }
    
    public func popToRootViewController(animated: Bool) -> [UIViewController]? {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        navigationController?.setViewControllers(viewControllers, animated: animated)
    }
    
    
    public func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
        navigationController?.present(viewControllerToPresent, animated: animated, completion: completion)
    }
    
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }
}
