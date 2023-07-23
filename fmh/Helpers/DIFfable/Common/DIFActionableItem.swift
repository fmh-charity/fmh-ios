//
//  DIFActionableItemL.swift
//  fmh
//
//  Created: 23.05.2023
//

import Foundation

// УДАЛИТЬ !!!

class DIFActionableItem: DIFItem, DIFActionable {
    
    var didTap: DidTap?
    
    init(id: String, action: DidTap? = nil) {
        self.didTap = action
        super.init(id: id)
    }
}
