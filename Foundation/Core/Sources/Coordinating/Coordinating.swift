import UIKit

public protocol Coordinating: AnyObject {
    associatedtype Destination
    
    var childCoordinators: [any Coordinating] { get set }
    var onCompletion: (() -> Void)? { get set }
    
    func navigate(to destination: Destination)
}

// MARK: - Defaults

public extension Coordinating {
    
    var childCoordinators: [any Coordinating] {
        get { [] }
        set { }
    }
    
    var onCompletion: (() -> Void)? {
        get { nil }
        set { }
    }
}

// MARK: - Child coordinators logics

public extension Coordinating {
    
    func childAppend(_ child: any Coordinating) {
        for element in childCoordinators {
            if element === child { return }
        }
        childCoordinators.append(child)
    }
    
    func childRemove(_ child: any Coordinating) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}

// MARK: - EXAMPLE

/*
private final class CoordinatingProvider: Coordinating {
    
    let router: Routing
    
    init(router: Routing) {
        self.router = router
    }
    
    // MARK: - Destinations
    
    enum Destination {
        case login(login: String, password: String)
        case logout
    }
    
    func navigate(to destination: Destination) {
        switch destination {
        case .login(_, _):
            break
        case .logout:
            router.dismiss(animated: true, completion: nil)
            self.childRemove(self)
        }
    }
}
*/
