//
//  DIFCollectionViewController.swift
//  fmh
//
//  Created: 23.05.2023
//

import UIKit

@available(iOS 13.0, tvOS 13.0, *)
class DIFCollectionViewController: UICollectionViewController {
    
    typealias DIFDataSource = DIFCollectionViewDataSource
    typealias DIFDataSourceSnapshot = DIFCollectionViewDataSource.Snapshot
    
    var diffDataSource: DIFDataSource?
    
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        collectionView.delaysContentTouches = false
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = configureLayouts() ?? UICollectionViewLayout()
        
        diffDataSource = .init(collectionView: collectionView, sections: content)
        collectionView.dataSource = diffDataSource
    }
    
    func configureLayouts() -> UICollectionViewLayout? {
        /* Override in child */
        nil
    }
    
    var content: [DIFSection] {
        /* Override in child */
        []
    }
}
