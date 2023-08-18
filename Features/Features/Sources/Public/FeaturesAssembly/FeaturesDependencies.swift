
import Foundation
import Coordinating

// MARK: Зависимости для всех модулей

public struct FeaturesDependencies {

    public let router: RouterProtocol
    
    public init(router: RouterProtocol) {
        self.router = router
    }
}
