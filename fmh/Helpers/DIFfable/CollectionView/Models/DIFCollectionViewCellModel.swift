
import UIKit

@available(iOS 13.0, tvOS 13.0, *)
open class DIFCollectionViewCellModel<T: DIFCollectionViewCellProtocol>: DIFActionableItem, DIFCollectionViewCellModelProtocol {
    
    public var reuseIdentifier: String { String(describing: T.self) }
    
    public init(_ collectionView: UICollectionView, id: String) {
        
        super.init(id: id, action: nil)
        collectionView.register(T.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    public func getCell(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        (cell as? T)?.indexPath = indexPath
        (cell as? T)?.model = self
        
        return cell
    }
    
}
