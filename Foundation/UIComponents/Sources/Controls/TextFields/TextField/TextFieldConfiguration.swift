
import UIKit

// MARK: Конфигурация TextField

public struct TextFieldConfiguration {
    
    public var text: String?
    public var placeholder: String?
    public var state: ControlState?
    public var style: TextFieldConfiguration.Style
    
    public init(
        text: String? = nil,
        placeholder: String? = nil,
        state: ControlState? = nil,
        style: TextFieldConfiguration.Style
    ) {
        self.text = text
        self.placeholder = placeholder
        self.state = state
        self.style = style
    }
}

// MARK: Стиль TextFie

extension TextFieldConfiguration {
    
    public struct Style {
        
        public var size: CGSize?
        public var contentEdgeInsets: UIEdgeInsets?
        public var backgroundColors: [ControlState.Color]?
        public var texts: [ControlState.Text]
        public var placeholders: [ControlState.Text]
        public var clearButtonMode: UITextField.ViewMode?
        public var leftViews: [ControlState.View]?
        public var leftViewMode: UITextField.ViewMode?
        public var leftViewEdgeInsets: UIEdgeInsets?
        public var rightViews: [ControlState.View]?
        public var rightViewMode: UITextField.ViewMode?
        public var rightViewEdgeInsets: UIEdgeInsets?
        public var corners: UIView.Corners?
        public var borders: [ControlState.Borders]?
        
        public init(
            size: CGSize? = nil,
            contentEdgeInsets: UIEdgeInsets? = nil,
            backgroundColors: [ControlState.Color]? = nil,
            texts: [ControlState.Text] = [],
            placeholders: [ControlState.Text] = [],
            clearButtonMode: UITextField.ViewMode? = nil,
            leftViews: [ControlState.View]? = nil,
            leftViewMode: UITextField.ViewMode? = nil,
            leftViewEdgeInsets: UIEdgeInsets? = nil,
            rightViews: [ControlState.View]? = nil,
            rightViewMode: UITextField.ViewMode? = nil,
            rightViewEdgeInsets: UIEdgeInsets? = nil,
            corners: UIView.Corners? = nil,
            borders: [ControlState.Borders]? = nil
        ) {
            self.size = size
            self.contentEdgeInsets = contentEdgeInsets
            self.backgroundColors = backgroundColors
            self.texts = texts
            self.placeholders = placeholders
            self.clearButtonMode = clearButtonMode
            self.leftViews = leftViews
            self.leftViewMode = leftViewMode
            self.leftViewEdgeInsets = leftViewEdgeInsets
            self.rightViews = rightViews
            self.rightViewMode = rightViewMode
            self.rightViewEdgeInsets = rightViewEdgeInsets
            self.corners = corners
            self.borders = borders
        }
    }
}
