
import UIKit

extension ControlState {
    
    public struct Color {
        
        public var state: ControlState
        public var color: UIColor
        
        public init(state: ControlState, color: UIColor) {
            self.state = state
            self.color = color
        }
    }
}
