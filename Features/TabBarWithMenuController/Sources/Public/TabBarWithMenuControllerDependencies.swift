
import UIKit
import Networking

public struct TabBarWithMenuControllerDependencies {

    public var onCompletion: (() -> Void)?
    public let network: NetworkProtocol
    public var viewControllers: [UIViewController]
    public var sideMenuSectionItems: [SideMenuSection: [SideMenuItem]]
    
    public init(
        onCompletion: (() -> Void)? = nil,
        network: NetworkProtocol,
        viewControllers: [UIViewController],
        sideMenuSectionItems: [SideMenuSection: [SideMenuItem]]
    ) {
        self.onCompletion = onCompletion
        self.network = network
        self.viewControllers = viewControllers
        self.sideMenuSectionItems = sideMenuSectionItems
    }
}
