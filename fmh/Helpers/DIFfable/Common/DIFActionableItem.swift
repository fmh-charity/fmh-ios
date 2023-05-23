
import Foundation

open class DIFActionableItem: DIFItem, DIFActionable {
    
    public var didTap: DidTap?
    
    public init(id: String, action: DidTap? = nil) {
        self.didTap = action
        super.init(id: id)
    }
    
}
