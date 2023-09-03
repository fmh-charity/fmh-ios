
import UIKit

extension ControlState {
    
    public struct View {
        
        public var state: ControlState
        public var view: UIView?
        
        public init(state: ControlState, view: UIView?) {
            self.state = state
            self.view = view
        }
    }
}
