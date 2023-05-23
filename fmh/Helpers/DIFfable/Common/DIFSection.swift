
import Foundation

open class DIFSection: DIFItem {
    
    open var header: DIFItem?
    open var footer: DIFItem?
    open var items: [DIFItem]
    
    public init(id: String, header: DIFItem? = nil, footer: DIFItem? = nil, items: [DIFItem] = []) {
        self.header = header
        self.footer = footer
        self.items = items
        
        super.init(id: id)
    }
    
}
