
import UIKit

public extension ControlState {
    
    var convertToUIControlState: UIControl.State {
        switch self {
        case .disabled:
            return .disabled
        case .normal, .readOnly, .warning, .error:
            return .normal
        case .highlighted:
            return .highlighted
        case .selected:
            return .selected
        case .focused:
            return .focused
        }
    }
}
