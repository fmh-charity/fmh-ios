
import UIKit

@available(iOS 13.0, tvOS 13.0, *)
public protocol DIFCollectionViewCellModelProtocol: AnyObject {
    
    func getCell(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell
    
}
