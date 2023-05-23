
import UIKit

@available(iOS 13.0, tvOS 13.0, *)
public protocol DIFCollectionViewCellProtocol: UICollectionViewCell {
    
    var indexPath: IndexPath? { get set }
    var model: DIFItem? { get set }
    
}

