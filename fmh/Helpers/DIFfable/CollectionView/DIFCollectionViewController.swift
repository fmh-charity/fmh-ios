
import UIKit

@available(iOS 13.0, tvOS 13.0, *)
open class DIFCollectionViewController: UICollectionViewController {
    
    public typealias DIFDataSource = DIFCollectionViewDataSource
    public typealias DIFDataSourceSnapshot = DIFCollectionViewDataSource.Snapshot
    
    public var diffDataSource: DIFDataSource?
    
    public init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open func commonInit() {
        collectionView.delaysContentTouches = false
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = configureLayouts() ?? UICollectionViewLayout()
        
        diffDataSource = .init(collectionView: collectionView, sections: content)
        collectionView.dataSource = diffDataSource
    }
    
    open func configureLayouts() -> UICollectionViewLayout? {
        /* Override in child */
        nil
    }
    
    open var content: [DIFSection] {
        /* Override in child */
        []
    }
    
}
