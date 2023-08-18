import Foundation

/// Поддержка Deeplink, в основном для координатора.
public protocol DeeplinkProtocol: AnyObject {
    var rootCoordinator: DeeplinkProtocol? { get }
    func navigate(to deepLink: Deeplink)
}

// MARK: - Default

public extension DeeplinkProtocol {
    
    func navigate(to deepLink: Deeplink) {
        if let rootCoordinator {
            rootCoordinator.navigate(to: deepLink)
        }
    }
}

// MARK: - Deeplink

public protocol Deeplink { }
