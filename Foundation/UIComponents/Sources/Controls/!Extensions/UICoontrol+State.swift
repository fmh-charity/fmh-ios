
import UIKit

extension UIControl.State: Hashable {
    
    public var description: String {
        switch self {
        case .normal: return "normal"
        case .highlighted: return "highlighted"
        case .disabled: return "disabled"
        case .selected: return "selected"
        case .focused: return "focused"
        case .application: return "application"
        case .reserved: return "reserved"
        case .readOnly: return "readOnly"
        case .warning: return "warning"
        case .error: return "error"
        default: return ""
        }
    }
}

public extension UIControl.State {
    static let readOnly = UIControl.State(rawValue: 1 << 14)
    static let warning = UIControl.State(rawValue: 1 << 15)
    static let error = UIControl.State(rawValue: 1 << 16)
}
