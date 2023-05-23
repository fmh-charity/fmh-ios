
import UIKit

@available(iOS 13.0, tvOS 13.0, *)
public protocol DIFCollectionReusableViewProtocol: UICollectionReusableView {
    
    var indexPath: IndexPath? { get set }
    var model: DIFItem? { get set }
    
}
