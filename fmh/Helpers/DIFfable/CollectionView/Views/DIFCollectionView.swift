//
//  DIFCollectionView.swift
//  fmh
//
//  Created: 23.05.2023
//

import UIKit

@available(iOS 13.0, tvOS 13.0, *)
class DIFCollectionView: UICollectionView {
    
    typealias DIFDataSource = DIFCollectionViewDataSource
    typealias DIFDataSourceSnapshot = DIFCollectionViewDataSource.Snapshot
    
    var diffDataSource: DIFDataSource?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .clear
        delaysContentTouches = false
        
        diffDataSource = .init(collectionView: self)
        self.dataSource = diffDataSource
    }
}
