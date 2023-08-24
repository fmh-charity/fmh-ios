
import UIKit

// MARK: Стиль Button

public struct ButtonStyle {
    
    public var size: CGSize?
    public var backgroundColor: UIColor?
    public var corners: UIView.Corners?
    public var shadow: UIView.Shadow?
    public var borders: UIView.Borders?
    public var highlightedScale: CGFloat?
    public var stateStyles: [StateStyle]?
    
    public init(
        size: CGSize? = nil,
        backgroundColor: UIColor? = nil,
        corners: UIView.Corners? = nil,
        shadow: UIView.Shadow? = nil,
        borders: UIView.Borders? = nil,
        highlightedScale: CGFloat? = nil,
        stateStyles: [StateStyle]? = nil
    ) {
        self.size = size
        self.backgroundColor = backgroundColor
        self.corners = corners
        self.shadow = shadow
        self.borders = borders
        self.stateStyles = stateStyles
    }
    
    // MARK: - Стиль для UIControl.State
    
    public struct StateStyle {
        
        public var state: UIControl.State
        public var backgroundImage: UIImage?
        public var titleStyle: TitleStyle?
        
        public init(
            state: UIControl.State,
            backgroundImage: UIImage? = nil,
            titleStyle: TitleStyle? = nil
        ) {
            self.state = state
            self.backgroundImage = backgroundImage
            self.titleStyle = titleStyle
        }
    }
    
    // MARK: - Стиль для title
    
    public struct TitleStyle {
        
        public var color: UIColor
        public var font: UIFont
        
        public init(
            color: UIColor,
            font: UIFont
        ) {
            self.color = color
            self.font = font
        }
    }
}
