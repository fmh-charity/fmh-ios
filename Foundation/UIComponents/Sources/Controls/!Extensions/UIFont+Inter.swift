
import UIKit

public extension UIFont {
    
    // MARK: Inter-Regular
    static func interRegular(ofSize: CGFloat) -> UIFont? {
        FontRegister(named: "Inter-Regular").font(ofSize: ofSize)
    }
    
    static func interRegular(textStyle: UIFont.TextStyle) -> UIFont? {
        FontRegister(named: "Inter-Regular").font(textStyle: textStyle)
    }
    
    // MARK: Inter-Light
    static func interLight(ofSize: CGFloat) -> UIFont? {
        FontRegister(named: "Inter-Light").font(ofSize: ofSize)
    }
    
    static func interLight(textStyle: UIFont.TextStyle) -> UIFont? {
        FontRegister(named: "Inter-Light").font(textStyle: textStyle)
    }
    
    // MARK: Inter-Medium
    static func interMedium(ofSize: CGFloat) -> UIFont? {
        FontRegister(named: "Inter-Medium").font(ofSize: ofSize)
    }
    
    static func interMedium(textStyle: UIFont.TextStyle) -> UIFont? {
        FontRegister(named: "Inter-Medium").font(textStyle: textStyle)
    }
    
    // MARK: Inter-Bold
    static func interBold(ofSize: CGFloat) -> UIFont? {
        FontRegister(named: "Inter-Bold").font(ofSize: ofSize)
    }
    
    static func interBold(textStyle: UIFont.TextStyle) -> UIFont? {
        FontRegister(named: "Inter-Bold").font(textStyle: textStyle)
    }
    
    // MARK: Inter-ExtraBold
    static func interExtraBold(ofSize: CGFloat) -> UIFont? {
        FontRegister(named: "Inter-ExtraBold").font(ofSize: ofSize)
    }
    
    static func interExtraBold(textStyle: UIFont.TextStyle) -> UIFont? {
        FontRegister(named: "Inter-ExtraBold").font(textStyle: textStyle)
    }
}
