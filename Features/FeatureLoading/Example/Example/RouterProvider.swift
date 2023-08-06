//
//  RouterProvider.swift
//  Example
//
//  Created by Константин Туголуков on 05.08.2023.
//

import Foundation
import Core
import UIKit

class RoutingProvider {

    private weak var window: UIWindow?
    private weak var navigationController: UINavigationController?

    init(window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
    }
}

// MARK: - Routable

extension RoutingProvider: Routing {

    var topViewController: UIViewController? {
        navigationController?.topViewController
    }

    var visibleViewController: UIViewController? {
        navigationController?.visibleViewController
    }

    var viewControllers: [UIViewController] {
        navigationController?.viewControllers ?? []
    }


    func setRootViewController(_ viewController: UIViewController?) {
        window?.rootViewController = viewController
    }

    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func popViewController(animated: Bool) -> UIViewController? {
        navigationController?.popViewController(animated: animated)
    }

    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        navigationController?.popToViewController(viewController, animated: animated)
    }

    func popToRootViewController(animated: Bool) -> [UIViewController]? {
        navigationController?.popToRootViewController(animated: animated)
    }

    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        navigationController?.setViewControllers(viewControllers, animated: animated)
    }


    func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
        navigationController?.present(viewControllerToPresent, animated: animated, completion: completion)
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }
}
