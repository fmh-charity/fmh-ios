
import UIKit

public extension UIFont {
    
    // MARK: Inter-Regular
    static func interRegular(_ ofSize: CGFloat) -> UIFont? {
        FontRegister(named: "Inter-Regular").font(ofSize: ofSize)
    }
    
    static func interRegular(_ textStyle: UIFont.TextStyle) -> UIFont? {
        FontRegister(named: "Inter-Regular").font(textStyle: textStyle)
    }
    
    // MARK: Inter-Light
    static func interLight(_ ofSize: CGFloat) -> UIFont? {
        FontRegister(named: "Inter-Light").font(ofSize: ofSize)
    }
    
    static func interLight(_ textStyle: UIFont.TextStyle) -> UIFont? {
        FontRegister(named: "Inter-Light").font(textStyle: textStyle)
    }
    
    // MARK: Inter-Medium
    static func interMedium(_ ofSize: CGFloat) -> UIFont? {
        FontRegister(named: "Inter-Medium").font(ofSize: ofSize)
    }
    
    static func interMedium(_ textStyle: UIFont.TextStyle) -> UIFont? {
        FontRegister(named: "Inter-Medium").font(textStyle: textStyle)
    }
    
    // MARK: Inter-Bold
    static func interBold(_ ofSize: CGFloat) -> UIFont? {
        FontRegister(named: "Inter-Bold").font(ofSize: ofSize)
    }
    
    static func interBold(_ textStyle: UIFont.TextStyle) -> UIFont? {
        FontRegister(named: "Inter-Bold").font(textStyle: textStyle)
    }
}
