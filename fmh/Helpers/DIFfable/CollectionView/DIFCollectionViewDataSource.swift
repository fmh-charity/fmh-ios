//
//  DIFCollectionViewDataSource.swift
//  fmh
//
//  Created: 23.05.2023
//

import UIKit

@available(iOS 13.0, tvOS 13.0, *)
class DIFCollectionViewDataSource: UICollectionViewDiffableDataSource<DIFItem, DIFItem> {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<DIFItem, DIFItem>
    
    init(collectionView: UICollectionView, sections: [DIFSection] = []) {
        
        super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            
            guard let item = itemIdentifier as? DIFCollectionViewCellModelProtocol
            else { return nil }
            
            return item.getCell(collectionView, for: indexPath)
        }
        
        self.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            return self.supplementary(collectionView: collectionView, elementKind: kind, indexPath: indexPath)
        }
        
        apply(sections: sections)
    }
    
    func apply(sections: [DIFSection], animatingDifferences: Bool = false, completion: (() -> Void)? = nil) {
        
        var snapshot = Snapshot()
        
        snapshot.appendSections(sections)
        
        sections.forEach {
            snapshot.appendItems($0.items, toSection: $0)
        }
        
        self.apply(snapshot, animatingDifferences: animatingDifferences, completion: completion)
    }
    
    func supplementary(collectionView: UICollectionView, elementKind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        
        guard let section = self.snapshot().sectionIdentifiers[indexPath.section] as? DIFSection
        else { return nil }
        
        // Header
        if let item = section.header as? DIFCollectionReusableViewModelProtocol, item.elementKind == elementKind {
            
            let view = item.getView(collectionView, for: indexPath)
            return view
        }
        
        // Footer
        if let item = section.footer as? DIFCollectionReusableViewModelProtocol, item.elementKind == elementKind {
            
            let view = item.getView(collectionView, for: indexPath)
            return view
        }
        
        // SupplementaryItems
        if let item = self.itemIdentifier(for: indexPath) as? DIFCollectionViewCellModelSupplementable {
            
            if let item = item.supplementaryItems.first(where: { $0.elementKind == elementKind }) {
                let view = item.getView(collectionView, for: indexPath)
                return view
            }
        }
        
        return nil
    }
}
