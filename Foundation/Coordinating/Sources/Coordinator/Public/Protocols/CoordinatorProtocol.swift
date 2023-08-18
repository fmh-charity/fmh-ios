import Foundation

/// Координатор.
public protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var onCompletion: (() -> Void)? { get set }
    func startFlow()
}

// MARK: - Defaults

public extension CoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] {
        get { [] }
        set { }
    }
    
    var onCompletion: (() -> Void)? {
        get { nil }
        set { }
    }
}

// MARK: - Child coordinators logics

public extension CoordinatorProtocol {
    
    func childCoordinatorAppend(_ child: CoordinatorProtocol) {
        childCoordinators.forEach { if $0 === child { return } }
        childCoordinators.append(child)
    }
    
    func childCoordinatorRemove(_ child: CoordinatorProtocol?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}

/*
// MARK: - EXAMPLE

final class ExampleCoordinatorProvider: CoordinatorProtocol, DeeplinkProtocol {
    
    // Dependencies
    let router: RouterProtocol
    
    // Public for Protocols
    var childCoordinators: [CoordinatorProtocol] = []
    var onCompletion: (() -> Void)?
    var rootCoordinator: DeeplinkProtocol?
    
    // MARK: - Life cycle
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    // MARK: - CoordinatorProtocol
    
    func startFlow() {
        navigate(to: .exampleFlow)
    }
    
    // MARK: - CoordinatorProtocol
    
    func navigate(to deepLink: Deeplink) {
        
        // coordinate self ...
        
        if let rootCoordinator {
            rootCoordinator.navigate(to: deepLink)
        }
    }
}

// MARK: - NavigateFlowProtocol

extension ExampleCoordinatorProvider: NavigateFlowProtocol {
    
    enum Flow {
        case exampleFlow
    }
    
    func navigate(to flow: Flow) {
        switch flow {
        case .exampleFlow: performExampleFlow()
        }
    }
}

// MARK: - Flows coordinator

private extension ExampleCoordinatorProvider {
    
    func performExampleFlow() {
        let vc = UIViewController()
        vc.view.backgroundColor = .gray
        router.pushViewController(vc, animated: true, onCompletion: nil)
    }
}
*/
