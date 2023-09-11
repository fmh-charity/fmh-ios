
import UIKit

public final class RegistrationAssembly {
    
    private let dependencies: RegistrationDependencies
    
    public init(dependencies: RegistrationDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - RegistrationAssemblyProtocol

extension RegistrationAssembly: RegistrationAssemblyProtocol {
    
   
}
