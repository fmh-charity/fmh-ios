
import UIKit

@available(iOS 13.0, tvOS 13.0, *)
public protocol DIFCollectionReusableViewModelProtocol: AnyObject {
    
    var elementKind: String { get }
    
    func getView(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionReusableView
    
}
