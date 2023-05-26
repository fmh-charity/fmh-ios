//
//  DIFActionable.swift
//  fmh
//
//  Created: 23.05.2023
//

import Foundation

protocol DIFActionable: AnyObject {
    
    var didTap: DidTap? { get set }
    
    typealias DidTap = (_ item: DIFItem, _ indexPath: IndexPath) -> Void
}
