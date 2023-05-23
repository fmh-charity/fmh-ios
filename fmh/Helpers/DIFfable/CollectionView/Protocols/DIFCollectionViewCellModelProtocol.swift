//
//  DIFCollectionViewCellModelProtocol.swift
//  fmh
//
//  Created: 23.05.2023
//

import UIKit

@available(iOS 13.0, tvOS 13.0, *)
protocol DIFCollectionViewCellModelProtocol: AnyObject {
    
    func getCell(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell
}
