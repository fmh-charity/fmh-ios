
import UIKit

public final class MoreAssembly {
    
    private let dependencies: MoreDependencies
    
    public init(dependencies: MoreDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - MoreAssemblyProtocol

extension MoreAssembly: MoreAssemblyProtocol {
    
    public var moreViewController: UIViewController {
        let presenter = MorePresenter(networkService: dependencies.network)
        let controller = MoreViewController(presenter: presenter)
        return controller
    }
}
