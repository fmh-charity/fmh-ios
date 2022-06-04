//
//  CollectionViewSection.swift
//  fmh
//
//  Created: 30.05.2022
//

import UIKit

struct CollectionViewSection {
    
    struct Header {
        let model: Any
        let viewType: UICollectionReusableView.Type
    }
    
    struct Item {
        let model: Any
        let viewType: UICollectionReusableView.Type
    }

    struct Footer {
        let model: Any
        let viewType: UICollectionReusableView.Type
    }
    
    let header: Header?
    var items: [Item]
    let footer: Footer?
    
    init(header: Header? = nil, items: [Item], footer: Footer? = nil) {
        self.header = header
        self.items = items
        self.footer = footer
    }
    
}
