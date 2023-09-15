
import Foundation
import Coordinating

public protocol FeaturesAssemblyProtocol {

    /// tabBarControllerCoordinator.
    var tabBarControllerCoordinator: CoordinatorProtocol { get }
    
    /// tabBarWithMenuControllerCoordinator.
    var tabBarWithMenuControllerCoordinator: CoordinatorProtocol { get }
    
    /// Загрузочная страница.
    var loadingCoordinator: CoordinatorProtocol { get }
    
    /// Страница Аутентификация пользователя.
    var authorizationCoordinator: CoordinatorProtocol { get }
}
