
import UIKit

// MARK: Состояние элемента управления.

public enum ControlState: String, CaseIterable, Equatable {
    case disabled
    case normal
    case highlighted
    case selected
    case focused
    case readOnly
    case warning
    case error
}
