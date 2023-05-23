
import UIKit

@available(iOS 13.0, tvOS 13.0, *)
open class DIFCollectionView: UICollectionView {
    
    public typealias DIFDataSource = DIFCollectionViewDataSource
    public typealias DIFDataSourceSnapshot = DIFCollectionViewDataSource.Snapshot
    
    open var diffDataSource: DIFDataSource?
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open func commonInit() {
        backgroundColor = .clear
        delaysContentTouches = false
        
        diffDataSource = .init(collectionView: self)
        self.dataSource = diffDataSource
    }
    
}
