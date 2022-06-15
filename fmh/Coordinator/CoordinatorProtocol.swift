//
//  CoordinatorProtocol.swift
//  fmh
//
//  Created: 14.05.2022
//

import UIKit

protocol CoordinatorProtocol : AnyObject {
   
    var childCoordinators: [CoordinatorProtocol] { get set }
    var onCompletion: (() -> ())? { get set }
    
    func start()
}

// MARK: - Append and remove childs coordinators
extension CoordinatorProtocol {
    
    func childAppend(_ child: CoordinatorProtocol) {
        childCoordinators.append(child)
    }
    
    func childRemove(_ child: CoordinatorProtocol?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}
