import Foundation

/// Поддержка навигации в координаторе.
public protocol NavigateFlowProtocol: AnyObject {
    associatedtype Flow
    func navigate(to flow: Flow)
}
