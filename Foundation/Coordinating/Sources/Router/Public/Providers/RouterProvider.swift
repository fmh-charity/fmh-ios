import UIKit

public class RouterProvider: NSObject {
    
    // Dependencies
    private let navigationController: UINavigationController
    private weak var window: UIWindow?
    
    // Properties
    private var completions: [UIViewController : () -> Void] = [:]
    
    // MARK: - Life cycle
    
    public init(window: UIWindow? = nil, navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }
    
    deinit {
        if let viewController = navigationController.presentedViewController {
            dismiss(viewController)
        }
    }
    
    // MARK: Private
    
    private func executeCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}

// MARK: - RouterProtocol

// TODO: Надо проверить как работает !!!
extension RouterProvider: RouterProtocol {
    
    // MARK: UINavigationController helpers
    
    public var rootViewController: UIViewController? {
        if let viewController = self.window?.rootViewController {
            return viewController
        }
        return navigationController
    }
    
    public var topViewController: UIViewController? {
        navigationController.topViewController
    }
    
    public var visibleViewController: UIViewController? {
        navigationController.visibleViewController
    }
    
    public var viewControllers: [UIViewController] {
        navigationController.viewControllers
    }
    
    // MARK: UIWindow
    
    public func rootViewController(_ viewController: UIViewController?) {
        window?.rootViewController = viewController
    }
    
    public func rootNavigationController(_ navigationController: UINavigationController?) {
        window?.rootViewController = navigationController ?? self.navigationController
    }
    
    // MARK: ViewController
    
    public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool = false, isNavigationBarHidden: Bool = false, onCompletion: (() -> Void)? = nil) {
        navigationController.viewControllers.forEach { executeCompletion(for: $0) }
        navigationController.setViewControllers(viewControllers, animated: animated)
        if let onCompletion {
            viewControllers.forEach { completions[$0] = onCompletion }
        }
        navigationController.isNavigationBarHidden = isNavigationBarHidden
    }
    
    public func pushViewController(_ viewController: UIViewController, animated: Bool = true, onCompletion: (() -> Void)? = nil) {
        if let onCompletion {
            completions[viewController] = onCompletion
        }
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    public func popViewController(animated: Bool = true) {
        if let viewController = navigationController.popViewController(animated: animated) {
            executeCompletion(for: viewController)
        }
    }
    
    public func popToRootViewController(animated: Bool) {
        if let viewControllers = navigationController.popToRootViewController(animated: animated) {
            viewControllers.forEach { executeCompletion(for: $0) }
        }
    }
    
    public func popToViewController(_ viewController: UIViewController, animated: Bool = true) {
        if let viewControllers = navigationController.popToViewController(viewController, animated: animated) {
            viewControllers.forEach { executeCompletion(for: $0) }
        }
    }
    
    public func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    public func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
    public func dismiss(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        if navigationController.presentedViewController == viewController {
            navigationController.dismiss(animated: animated, completion: completion)
        }
    }
}

// MARK: - UINavigationControllerDelegate

extension RouterProvider: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard
            let viewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(viewController)
        else {
            return
        }
        executeCompletion(for: viewController)
    }
}
