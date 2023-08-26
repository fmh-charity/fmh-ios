
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
            let shadowDefault = UIView.Shadow()
            self.layer.shadowColor = newValue?.cgColor ?? shadowDefault.cgColor
            self.layer.shadowOffset = newValue?.offSet ?? shadowDefault.offSet
            self.layer.shadowOpacity = newValue?.opacity ?? shadowDefault.opacity
            self.layer.shadowRadius = newValue?.radius ?? shadowDefault.radius
            self.layer.masksToBounds = false
        }
    }
}
