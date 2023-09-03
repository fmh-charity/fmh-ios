
import UIKit

extension ControlState {
    
    public struct Text {
        
        public var state: ControlState
        public var color: UIColor
        public var font: UIFont
        
        public init(state: ControlState, color: UIColor, font: UIFont) {
            self.state = state
            self.color = color
            self.font = font
        }
    }
}
