
import Foundation
import Coordinating

public protocol FeaturesAssemblyProtocol {

    /// Загрузочная страница.
    var loadingCoordinator: CoordinatorProtocol { get }
    /// Страница Аутентификация пользователя.
    var authorizationCoordinator: CoordinatorProtocol { get }
}
