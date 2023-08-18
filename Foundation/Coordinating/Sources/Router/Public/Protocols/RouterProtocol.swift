import UIKit

public protocol RouterProtocol {
    
    // MARK: UINavigationController helpers
    
    var rootViewController: UIViewController? { get }
    var topViewController: UIViewController? { get }
    var visibleViewController: UIViewController? { get }
    var viewControllers: [UIViewController] { get }
    
    // MARK: UIWindow
    
    func rootViewController(_ viewController: UIViewController?)
    
    // MARK: ViewController
    
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool, isNavigationBarHidden: Bool, onCompletion: (() -> Void)?)
    func pushViewController(_ viewController: UIViewController, animated: Bool, onCompletion: (() -> Void)?)
    func popViewController(animated: Bool)
    func popToRootViewController(animated: Bool)
    func popToViewController(_ viewController: UIViewController, animated: Bool)
    
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func dismiss(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    
    // Alerts
    
    // botomSheet
    
    // ...
}
