
import UIKit

// MARK: Конфигурация для TextFieldBasic

public struct TextFieldBasicConfiguration {
    
    public var size: CGFloat?
    public var corners: UIView.Corners?
    public var contentEdgeInsets: UIEdgeInsets?
    public var textEdgeInsets: UIEdgeInsets?
    public var leftViewEdgeInsets: UIEdgeInsets?
    public var rightViewEdgeInsets: UIEdgeInsets?
    public var clearButtonMode: UITextField.ViewMode?
    public var leftViewMode: UITextField.ViewMode?
    public var rightViewMode: UITextField.ViewMode?
    public var styles: [UIControl.State: TextFieldBasicConfiguration.Style]?
    
    public init(
        size: CGFloat? = nil,
        corners: UIView.Corners? = nil,
        contentEdgeInsets: UIEdgeInsets? = nil,
        textEdgeInsets: UIEdgeInsets? = nil,
        leftViewEdgeInsets: UIEdgeInsets? = nil,
        rightViewEdgeInsets: UIEdgeInsets? = nil,
        clearButtonMode: UITextField.ViewMode? = nil,
        leftViewMode: UITextField.ViewMode? = nil,
        rightViewMode: UITextField.ViewMode? = nil,
        styles: [UIControl.State : TextFieldBasicConfiguration.Style]? = nil
    ) {
        self.size = size
        self.corners = corners
        self.contentEdgeInsets = contentEdgeInsets
        self.textEdgeInsets = textEdgeInsets
        self.leftViewEdgeInsets = leftViewEdgeInsets
        self.rightViewEdgeInsets = rightViewEdgeInsets
        self.clearButtonMode = clearButtonMode
        self.leftViewMode = leftViewMode
        self.rightViewMode = rightViewMode
        self.styles = styles
    }
}

// MARK: Стиль для TextFieldBasic

extension TextFieldBasicConfiguration {
    
    public struct Style {
        
        public var backgroundColor: UIColor?
        public var borders: UIView.Borders?
        public var leftView: UIView?
        public var rightView: UIView?
        public var textStyle: TextStyle?
        public var placeholderStyle: TextStyle?
        
        public init(
            backgroundColor: UIColor? = nil,
            borders: UIView.Borders? = nil,
            leftView: UIView? = nil,
            rightView: UIView? = nil,
            textStyle: TextStyle? = nil,
            placeholderStyle: TextStyle? = nil
        ) {
            self.backgroundColor = backgroundColor
            self.borders = borders
            self.leftView = leftView
            self.rightView = rightView
            self.textStyle = textStyle
            self.placeholderStyle = placeholderStyle
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
