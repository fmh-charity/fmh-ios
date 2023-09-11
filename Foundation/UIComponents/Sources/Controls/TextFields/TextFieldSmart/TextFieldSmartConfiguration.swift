
import UIKit

// MARK: Конфигурация для TextFieldSmart

public struct TextFieldSmartConfiguration {
    
    public var size: CGFloat?
    public var corners: UIView.Corners?
    public var contentEdgeInsets: UIEdgeInsets?
    public var textEdgeInsets: UIEdgeInsets?
    public var clearButtonEdgeInsets: UIEdgeInsets?
    public var clearButtonMode: UITextField.ViewMode?
    public var styles: [UIControl.State: TextFieldSmartConfiguration.Style]?
    
    public init(
        size: CGFloat? = nil,
        corners: UIView.Corners? = nil,
        contentEdgeInsets: UIEdgeInsets? = nil,
        textEdgeInsets: UIEdgeInsets? = nil,
        clearButtonEdgeInsets: UIEdgeInsets? = nil,
        clearButtonMode: UITextField.ViewMode? = nil,
        styles: [UIControl.State : TextFieldSmartConfiguration.Style]? = nil
    ) {
        self.size = size
        self.corners = corners
        self.contentEdgeInsets = contentEdgeInsets
        self.textEdgeInsets = textEdgeInsets
        self.clearButtonEdgeInsets = clearButtonEdgeInsets
        self.clearButtonMode = clearButtonMode
        self.styles = styles
    }
}

// MARK: Стиль для TextFieldSmart

extension TextFieldSmartConfiguration {
    
    public struct Style {
        
        public var backgroundColor: UIColor?
        public var borders: UIView.Borders?
        public var titleStyle: TextStyle?
        public var textStyle: TextStyle?
        public var placeholderStyle: TextStyle?
        public var promptStyle: TextStyle?
        public var clearButtonImage: UIImage?
        
        public init(
            backgroundColor: UIColor? = nil,
            borders: UIView.Borders? = nil,
            titleStyle: TextStyle? = nil,
            textStyle: TextStyle? = nil,
            placeholderStyle: TextStyle? = nil,
            promptStyle: TextStyle? = nil,
            clearButtonImage: UIImage? = nil
        ) {
            self.backgroundColor = backgroundColor
            self.borders = borders
            self.titleStyle = titleStyle
            self.textStyle = textStyle
            self.placeholderStyle = placeholderStyle
            self.promptStyle = promptStyle
            self.clearButtonImage = clearButtonImage
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
