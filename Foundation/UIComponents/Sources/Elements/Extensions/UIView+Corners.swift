
import UIKit

public protocol ViewCornersAvailable: UIView {
    var corners: UIView.Corners? { get set }
}

// MARK: - UIView + Corners

extension UIView {
    
    public struct Corners {
        public let corners: CACornerMask
        public let radius: CGFloat
        
        public init(
            corners: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner],
            radius: CGFloat = 0.0
        ) {
            self.corners = corners
            self.radius = radius
        }
    }
}

// MARK: - ViewCornersAvailable + Corners

extension ViewCornersAvailable where Self: UIView {
    
    public var corners: UIView.Corners? {
        get {
            return .init(corners: self.layer.maskedCorners, radius: self.layer.cornerRadius)
        }
        set {
            let corners = Corners()
            self.layer.maskedCorners = newValue?.corners ?? corners.corners
            self.layer.cornerRadius = newValue?.radius ?? corners.radius
            self.layer.masksToBounds = self.layer.cornerRadius > 0.0
        }
    }
}


