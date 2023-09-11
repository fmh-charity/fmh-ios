
import UIKit

// MARK: Конфигурация для Button

public struct ButtonConfiguration {
    
    public var size: CGFloat?
    public var isCapsule: Bool?
    public var corners: UIView.Corners?
    public var highlightedScale: CGFloat?
    public var highlightedOpacity: Float?
    public var styles: [UIControl.State: ButtonConfiguration.Style]?
    
    public init(
        size: CGFloat? = nil,
        isCapsule: Bool? = nil,
        corners: UIView.Corners? = nil,
        highlightedScale: CGFloat? = nil,
        highlightedOpacity: Float? = nil,
        styles: [UIControl.State : ButtonConfiguration.Style]? = nil
    ) {
        self.size = size
        self.isCapsule = isCapsule
        self.corners = corners
        self.highlightedScale = highlightedScale
        self.highlightedOpacity = highlightedOpacity
        self.styles = styles
    }
}

// MARK: Стиль для Button

extension ButtonConfiguration {
    
    public struct Style {
        
        public var backgroundColor: UIColor?
        public var borders: UIView.Borders?
        public var shadows: UIView.Shadow?
        public var titleStyle: TextStyle?
        
        public init(
            backgroundColor: UIColor? = nil,
            borders: UIView.Borders? = nil,
            shadows: UIView.Shadow? = nil,
            titleStyle: TextStyle? = nil
        ) {
            self.backgroundColor = backgroundColor
            self.borders = borders
            self.shadows = shadows
            self.titleStyle = titleStyle
        }
        
        public struct TextStyle {
            var color: UIColor
            var font: UIFont
            init(color: UIColor, font: UIFont) {
                self.color = color
                self.font = font
            }
        }
    }
}
