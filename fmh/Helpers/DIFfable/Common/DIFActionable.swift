
import Foundation

public protocol DIFActionable: AnyObject {
    
    var didTap: DidTap? { get set }
    
    typealias DidTap = (_ item: DIFItem, _ indexPath: IndexPath) -> Void
    
}
