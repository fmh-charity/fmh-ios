
import UIKit

// MARK: Размеры Buttons

// TODO: Сделать разные под размер экрана!

public enum ButtonSize: CGFloat {
    case `default` = 44.0
    case small = 28.0
    case medium = 34.0
    case large = 50.0
}

// MARK: Sizes button

extension CGSize {
    static let defaultSizeButton = CGSize(width: .zero, height: ButtonSize.default.rawValue)
    static let smallSizeButton = CGSize(width: .zero, height: ButtonSize.small.rawValue)
    static let mediumSizeButton = CGSize(width: .zero, height: ButtonSize.medium.rawValue)
    static let largeSizeButton = CGSize(width: .zero, height: ButtonSize.large.rawValue)
}
