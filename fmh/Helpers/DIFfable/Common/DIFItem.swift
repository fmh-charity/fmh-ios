//
//  DIFItem.swift
//  fmh
//
//  Created: 23.05.2023
//

import Foundation

class DIFItem: NSObject {
    
    var id: String
    
    init(id: String) {
        self.id = id
    }
    
    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(id)
        return hasher.finalize()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? DIFItem else { return false }
        return id == object.id
    }
}
