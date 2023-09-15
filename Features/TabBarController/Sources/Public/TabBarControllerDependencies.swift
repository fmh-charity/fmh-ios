
import UIKit

public struct TabBarControllerDependencies {

    public var onCompletion: (() -> Void)?
    public var viewControllers: [UIViewController]
    
    public init(
        onCompletion: (() -> Void)? = nil,
        viewControllers: [UIViewController]
    ) {
        self.onCompletion = onCompletion
        self.viewControllers = viewControllers
    }
}
