
import UIKit

public protocol ViewBordersAvailable: UIView {
    var borders: UIView.Borders? { get set }
}

// MARK: - UIView + Borders

extension UIView {
    
    public struct Borders {
        public let cgColor: CGColor?
        public let width: CGFloat
        
        public init(
            cgColor: CGColor? = nil,
            width: CGFloat = 0.0
        ) {
            self.cgColor = cgColor
            self.width = width
        }
    }
}

// MARK: - ViewBordersAvailable + Borders

extension ViewBordersAvailable where Self: UIView {
    
    public var borders: UIView.Borders? {
        get {
            return .init(cgColor: self.layer.borderColor, width: self.layer.borderWidth)
        }
        set {
            let bordersDefault = UIView.Borders()
            self.layer.borderColor = newValue?.cgColor ?? bordersDefault.cgColor
            self.layer.borderWidth = newValue?.width ?? bordersDefault.width
        }
    }
}
