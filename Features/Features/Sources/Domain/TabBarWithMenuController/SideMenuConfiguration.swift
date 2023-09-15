
import UIKit
import TabBarWithMenuController

protocol SideMenuConfigurationProtocol {
    var sideMenuSectionItems: [SideMenuSection: [SideMenuItem]] { get }
}

class SideMenuConfiguration {
    
    // Dependencies
    private let dependencies: FeaturesDependencies
    
    // MARK: - Life cycle
    
    public init(dependencies: FeaturesDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - SideMenuConfigurationProtocol

extension SideMenuConfiguration: SideMenuConfigurationProtocol {
    
    var sideMenuSectionItems: [SideMenuSection: [SideMenuItem]] {
        [
            : // Тут определяем пункты меню + действия по тапу на них.
        ]
    }
}
