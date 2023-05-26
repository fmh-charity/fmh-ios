//
//  DIFCollectionReusableViewModel.swift
//  fmh
//
//  Created: 23.05.2023
//

import UIKit

@available(iOS 13.0, tvOS 13.0, *)
class DIFCollectionReusableViewModel<T: DIFCollectionReusableViewProtocol>: DIFActionableItem, DIFCollectionReusableViewModelProtocol {
    
    var elementKind: String
    
    var reuseIdentifier: String { String(describing: T.self) }
    
    init(_ collectionView: UICollectionView, id: String, forSupplementaryViewOfKind ofKind: String? = nil) {
        
        self.elementKind = ofKind ?? String(describing: T.self)
        
        super.init(id: id, action: nil)
        
        collectionView.register(T.self, forSupplementaryViewOfKind: self.elementKind, withReuseIdentifier: reuseIdentifier)
    }
    
    func getView(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionReusableView {
       
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: self.elementKind, withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        (view as? T)?.indexPath = indexPath
        (view as? T)?.model = self
        
        return view
    }
}
