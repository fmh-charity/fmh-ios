
import UIKit

public protocol ViewShadowAvailable: UIView {
    var shadow: UIView.Shadow? { get set }
}


// MARK: Shadow
extension UIView {
    
    public struct Shadow {
        public let cgColor: CGColor?
        public let offSet: CGSize
        public let opacity: Float
        public let radius: CGFloat
        
        init(
            cgColor: CGColor? = nil,
            offSet: CGSize = .init(width: 0.0, height: -3.0),
            opacity: Float = 0.0,
            radius: CGFloat = 3.0
        ) {
            self.cgColor = cgColor
            self.offSet = offSet
            self.opacity = opacity
            self.radius = radius
        }
    }
}

extension ViewShadowAvailable where Self: UIView {
    
    public var shadow: UIView.Shadow? {
        get {
            return UIView.Shadow(
                cgColor: self.layer.shadowColor,
                offSet: self.layer.shadowOffset,
                opacity: self.layer.shadowOpacity,
                radius: self.layer.shadowRadius
            )
        }
        set {
            let corners = (self as? ViewCornersAvailable)?.corners
            self.layer.shadowPath = corners != nil ? cgPathShadow : nil
            let shadowDefault = UIView.Shadow()
            self.layer.shadowColor = newValue?.cgColor ?? shadowDefault.cgColor
            self.layer.shadowOffset = newValue?.offSet ?? shadowDefault.offSet
            self.layer.shadowOpacity = newValue?.opacity ?? shadowDefault.opacity
            self.layer.shadowRadius = newValue?.radius ?? shadowDefault.radius
        }
    }
    
   private var cgPathShadow: CGPath {
        get {
            return UIBezierPath(
                roundedRect: self.bounds,
                byRoundingCorners: self.layer.maskedCorners.rectCorners,
                cornerRadii: CGSize(width: self.layer.cornerRadius, height: self.layer.cornerRadius)
            ).cgPath
        }
    }
}

// MARK: - utils

private extension CACornerMask {
    
    var rectCorners: UIRectCorner {
        get {
            var rectCorners = UIRectCorner()
            if self.contains(.layerMinXMinYCorner) {
                rectCorners.insert(.topLeft)
            }
            
            if self.contains(.layerMaxXMinYCorner) {
                rectCorners.insert(.topRight)
            }
            
            if self.contains(.layerMinXMaxYCorner) {
                rectCorners.insert(.bottomLeft)
            }
            
            if self.contains(.layerMaxXMaxYCorner) {
                rectCorners.insert(.bottomRight)
            }
            return rectCorners
        }
    }
}
