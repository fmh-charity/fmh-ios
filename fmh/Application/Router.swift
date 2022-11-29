//
//  Router.swift
//  fmh
//
//  Created: 26.11.2022
//

import UIKit

typealias RouterCompletions = [UIViewController : CompletionBlock]
typealias CompletionBlock = () -> Void

//MARK: - Routable
protocol Routable: Presentable {
    
    func present(_ screen: Presentable?)
    func present(_ screen: Presentable?, animated: Bool)
    
    func push(_ screen: Presentable?)
    func push(_ screen: Presentable?, animated: Bool)
    func push(_ screen: Presentable?, animated: Bool, completion: CompletionBlock?)
    
    func pop()
    func pop(animated: Bool)
    
    func dismiss()
    func dismiss(animated: Bool, completion: CompletionBlock?)
    
    func setRoot(_ screen: Presentable?)
    func setRoot(_ screen: Presentable?, hideBar: Bool)
    func setWindowRoot(_ screen: Presentable?)
    
    func popToRoot(animated: Bool)
    
}

//MARK: - Presentable
protocol Presentable: AnyObject {
    var toPresent: UIViewController? { get }
}

extension Presentable where Self: UIViewController {
    var toPresent: UIViewController? { return self }
}


//MARK: - Router
final class Router: NSObject {

//    typealias HandlersClosure = ([String: Any]?) -> ()
//    private var handlers = [String : HandlersClosure]()
    
    fileprivate weak var window: UIWindow?
    fileprivate weak var navigationController: UINavigationController?
    fileprivate var completions: RouterCompletions
    
    init(window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
        completions = [:]
    }
    
    var toPresent: UIViewController? {
        return navigationController
    }
}

// MARK: - Private methods
private extension Router {
    
    func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
}

//MARK: - Routable
extension Router: Routable {
    
    func present(_ screen: Presentable?) {
        present(screen, animated: true)
    }
    
    func present(_ screen: Presentable?, animated: Bool) {
        guard let controller = screen?.toPresent else { return }
        navigationController?.present(controller, animated: animated, completion: nil)
    }
    
    func push(_ screen: Presentable?)  {
        push(screen, animated: true)
    }
    
    func push(_ screen: Presentable?, animated: Bool)  {
        push(screen, animated: animated, completion: nil)
    }
    
    func push(_ screen: Presentable?, animated: Bool, completion: CompletionBlock?) {
        guard
            let controller = screen?.toPresent,
            !(controller is UINavigationController)
            else { assertionFailure("Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            completions[controller] = completion
        }
        navigationController?.pushViewController(controller, animated: animated)
    }
    
    func pop()  {
        pop(animated: true)
    }
    
    func pop(animated: Bool)  {
        if let controller = navigationController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func dismiss(animated: Bool, completion: CompletionBlock?) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }
    
    func setRoot(_ screen: Presentable?) {
        setRoot(screen, hideBar: false)
    }
    
    func setRoot(_ screen: Presentable?, hideBar: Bool) {
        guard let controller = screen?.toPresent else { return }
        navigationController?.setViewControllers([controller], animated: false)
        navigationController?.isNavigationBarHidden = hideBar
    }
    
    func setWindowRoot(_ screen: Presentable?) {
        guard let controller = screen?.toPresent else { return }
        window?.rootViewController = controller
    }
    
    func popToRoot(animated: Bool) {
        if let controllers = navigationController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
 
}
