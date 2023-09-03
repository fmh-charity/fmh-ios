
import UIKit

public struct TextFieldWithStateConfiguration {
    
    public var size: CGFloat?
    public var contentEdgeInsets: UIEdgeInsets?
    public var borderLayerEdgeInsets: UIEdgeInsets?
    public var borderCornerRadius: CGFloat?
    public var clearButtonMode: UITextField.ViewMode?
    public var clearButtonOffsetX: CGFloat?
    
    init(
        size: CGFloat? = nil,
        contentEdgeInsets: UIEdgeInsets? = nil,
        borderLayerEdgeInsets: UIEdgeInsets? = nil,
        borderCornerRadius: CGFloat? = nil,
        clearButtonMode: UITextField.ViewMode? = nil,
        clearButtonOffsetX: CGFloat? = nil
    ) {
        self.size = size
        self.contentEdgeInsets = contentEdgeInsets
        self.borderLayerEdgeInsets = borderLayerEdgeInsets
        self.borderCornerRadius = borderCornerRadius
        self.clearButtonMode = clearButtonMode
        self.clearButtonOffsetX = clearButtonOffsetX
    }
}

// MARK: - TextFieldWithStateConfiguration + StateStyle

extension TextFieldWithStateConfiguration {
    
    public struct StateStyle {
        
        public var backgroundColor: UIColor?
        public var borderColor: UIColor?
        public var titleStyle: TextStyle?
        public var textStyle: TextStyle?
        public var placeholderStyle: TextStyle?
        public var promptStyle: TextStyle?
        public var clearButtonImage: UIImage?
        
        public init(
            backgroundColor: UIColor? = nil,
            borderColor: UIColor? = nil,
            titleStyle: TextStyle? = nil,
            textStyle: TextStyle? = nil,
            placeholderStyle: TextStyle? = nil,
            promptStyle: TextStyle? = nil,
            clearButtonImage: UIImage? = nil
        ) {
            self.backgroundColor = backgroundColor
            self.borderColor = borderColor
            self.titleStyle = titleStyle
            self.textStyle = textStyle
            self.placeholderStyle = placeholderStyle
            self.promptStyle = promptStyle
            self.clearButtonImage = clearButtonImage
        }
        
        public typealias TextStyle = (UIColor, UIFont)
    }
}
