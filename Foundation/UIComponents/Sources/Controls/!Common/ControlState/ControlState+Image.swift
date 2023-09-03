import UIKit

extension ControlState {
    
    public struct Image {
        
        public var state: ControlState
        public var image: UIImage?
        
        public init(state: ControlState, image: UIImage?) {
            self.state = state
            self.image = image
        }
    }
}
