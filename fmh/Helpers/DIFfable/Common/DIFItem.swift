
import Foundation

open class DIFItem: NSObject {
    
    open var id: String
    
    public init(id: String) {
        self.id = id
    }
    
    open override var hash: Int {
        var hasher = Hasher()
        hasher.combine(id)
        return hasher.finalize()
    }
    
    open override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? DIFItem else { return false }
        return id == object.id
    }
    
}
