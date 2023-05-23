
import UIKit

@available(iOS 13.0, tvOS 13.0, *)
public protocol DIFCollectionViewCellModelSupplementable: AnyObject {
    
    var supplementaryItems: [DIFCollectionReusableViewModelProtocol] { get }
    
}
