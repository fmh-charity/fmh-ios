
import UIKit

extension ControlState {
    
    public struct Shadow {
        
        public var state: ControlState
        public var shadow: UIView.Shadow
        
        public init(state: ControlState, shadow: UIView.Shadow) {
            self.state = state
            self.shadow = shadow
        }
    }
}
