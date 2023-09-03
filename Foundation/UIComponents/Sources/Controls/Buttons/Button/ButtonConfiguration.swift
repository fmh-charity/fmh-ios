
import UIKit

// MARK: Конфигурация Button

public struct ButtonConfiguration {
    
    public var title: String?
    public var state: ControlState?
    public var style: ButtonConfiguration.Style
    
    public init(
        title: String? = nil,
        state: ControlState? = nil,
        style: ButtonConfiguration.Style
    ) {
        self.title = title
        self.state = state
        self.style = style
    }
}

// MARK: Стиль Button

extension ButtonConfiguration {
    
    public struct Style {
        
        public var size: CGSize?
        public var isCapsule: Bool?
        public var highlightedScale: CGFloat?
        public var highlightedOpacity: Float?
        public var backgroundColors: [ControlState.Color]
        public var titleStyles: [ControlState.Text]
        public var corners: UIView.Corners?
        public var borders: [ControlState.Borders]?
        public var shadows: [ControlState.Shadow]?
        
        public init(
            size: CGSize? = nil,
            isCapsule: Bool? = nil,
            highlightedScale: CGFloat? = nil,
            highlightedOpacity: Float? = nil,
            backgroundColors: [ControlState.Color] = [],
            titleStyles: [ControlState.Text] = [],
            corners: UIView.Corners? = nil,
            borders: [ControlState.Borders]? = nil,
            shadows: [ControlState.Shadow]? = nil
        ) {
            self.size = size
            self.isCapsule = isCapsule
            self.highlightedScale = highlightedScale
            self.highlightedOpacity = highlightedOpacity
            self.backgroundColors = backgroundColors
            self.titleStyles = titleStyles
            self.corners = corners
            self.borders = borders
            self.shadows = shadows
        }
    }
}
