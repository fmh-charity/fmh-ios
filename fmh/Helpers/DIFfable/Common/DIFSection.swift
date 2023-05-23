//
//  DIFSection.swift
//  fmh
//
//  Created: 23.05.2023
//

import Foundation

class DIFSection: DIFItem {
    
    var header: DIFItem?
    var footer: DIFItem?
    var items: [DIFItem]
    
    init(id: String, header: DIFItem? = nil, footer: DIFItem? = nil, items: [DIFItem] = []) {
        self.header = header
        self.footer = footer
        self.items = items
        
        super.init(id: id)
    }
}
