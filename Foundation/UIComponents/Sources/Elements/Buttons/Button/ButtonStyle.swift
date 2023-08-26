
import UIKit

// MARK: Стиль Button

public struct ButtonStyle {
    
    /// Размер кнопки.
    public var size: CGSize?
    
    /// Стиль кнопки капсула. Если true то игнорирует ButtonStyle.corners.
    public var isCapsule: Bool?
    
    /// Масштаб кнопки при нажатом состоянии.
    public var highlightedScale: CGFloat?
    
    /// Непрозрачность кнопки при нажатом состоянии.
    public var highlightedOpacity: Float?
    
    /// Цвет фона для состояний кнопки. Использовать поддерживаемые состояния Button.statesAvailable.
    /// Если используем состояние отличное от .normal, то необходимо конфигурировать для всех состояний.
    public var backgroundColors: [BackgroundColorState]
    
    /// Стиль титла для состояний кнопки. Использовать поддерживаемые состояния Button.statesAvailable.
    /// Если используем состояние отличное от .normal, то необходимо конфигурировать для всех состояний.
    public var titleStyles: [TitleStyleState]
    
    /// Закругленные углы.
    public var corners: UIView.Corners?
    
    /// Стиль границы для состояний кнопки. Использовать поддерживаемые состояния Button.statesAvailable.
    /// Если используем состояние отличное от .normal, то необходимо конфигурировать для всех состояний.
    public var borders: [BordersState]?
    
    /// Стиль тини для состояний кнопки. Использовать поддерживаемые состояния Button.statesAvailable.
    /// Если используем состояние отличное от .normal, то необходимо конфигурировать для всех состояний.
    public var shadows: [ShadowState]?
    
    public init(
        size: CGSize? = nil,
        isCapsule: Bool? = nil,
        highlightedScale: CGFloat? = nil,
        highlightedOpacity: Float? = nil,
        backgroundColors: [BackgroundColorState] = [],
        titleStyles: [TitleStyleState] = [],
        corners: UIView.Corners? = nil,
        borders: [BordersState]? = nil,
        shadows: [ShadowState]? = nil
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
    
    // MARK: - Стиль для UIControl.State
    
    /// Цвет фона для состояния.
    public struct BackgroundColorState {
        public var state: UIControl.State
        public var color: UIColor
        init(state: UIControl.State, color: UIColor) {
            self.state = state
            self.color = color
        }
    }
    
    /// Стиль титла кнопки для состояния.
    public struct TitleStyleState {
        public var state: UIControl.State
        public var color: UIColor
        public var font: UIFont?
        init(state: UIControl.State, color: UIColor, font: UIFont? = nil) {
            self.state = state
            self.color = color
            self.font = font
        }
    }
    
    /// Стиль границы для состояния.
    public struct BordersState {
        public var state: UIControl.State
        public var borders: UIView.Borders
        init(state: UIControl.State, borders: UIView.Borders) {
            self.state = state
            self.borders = borders
        }
    }
    
    /// Стиль тени для состояния.
    public struct ShadowState {
        public var state: UIControl.State
        public var shadow: UIView.Shadow
        init(state: UIControl.State, shadow: UIView.Shadow) {
            self.state = state
            self.shadow = shadow
        }
    }
}
