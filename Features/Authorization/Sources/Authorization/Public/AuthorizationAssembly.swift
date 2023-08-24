
import UIKit

public final class AuthorizationAssembly {
    
    private let dependencies: AuthorizationDependencies
    
    public init(dependencies: AuthorizationDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - AuthorizationAssemblyProtocol

extension AuthorizationAssembly: AuthorizationAssemblyProtocol {
    
    public var authorizationViewController: UIViewController {
        let presenter = AuthorizationPresenter()
        let viewController = AuthorizationViewController(presenter: presenter)
        presenter.delegate = viewController
        return viewController
    }
}
