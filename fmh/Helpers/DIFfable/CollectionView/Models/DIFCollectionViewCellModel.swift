//
//  DIFCollectionViewCellModel.swift
//  fmh
//
//  Created: 23.05.2023
//

import UIKit

@available(iOS 13.0, tvOS 13.0, *)
class DIFCollectionViewCellModel<T: DIFCollectionViewCellProtocol>: DIFActionableItem, DIFCollectionViewCellModelProtocol {
    
    var reuseIdentifier: String { String(describing: T.self) }
    
    init(_ collectionView: UICollectionView, id: String) {
        
        super.init(id: id, action: nil)
        collectionView.register(T.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func getCell(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        (cell as? T)?.indexPath = indexPath
        (cell as? T)?.model = self
        
        return cell
    }
}
