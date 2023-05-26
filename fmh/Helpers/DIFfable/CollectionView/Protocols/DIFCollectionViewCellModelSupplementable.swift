//
//  DIFCollectionViewCellModelSupplementable.swift
//  fmh
//
//  Created: 23.05.2023
//

import UIKit

@available(iOS 13.0, tvOS 13.0, *)
protocol DIFCollectionViewCellModelSupplementable: AnyObject {
    
    var supplementaryItems: [DIFCollectionReusableViewModelProtocol] { get }
}
