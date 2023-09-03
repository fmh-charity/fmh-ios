
import UIKit

extension ControlState {
    
    public struct Borders {
        
        public var state: ControlState
        public var borders: UIView.Borders
        
        public init(state: ControlState, borders: UIView.Borders) {
            self.state = state
            self.borders = borders
        }
    }
}
