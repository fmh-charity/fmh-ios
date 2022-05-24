//
//  BaseCoordinator.swift
//  fmh
//
//  Created: 20.05.2022
//

import Foundation

class BaseCoordinator : Coordinator {
    
    var childCoordinators = [Coordinator]()
    var isCompletion: (() -> ())?

    func start() {
        fatalError("Children should implement `start`.")
    }
    
}

// MARK: - Append and remove childs coordinators
extension BaseCoordinator {
    
    func childAppend(_ child: Coordinator) {
        childCoordinators.append(child)
    }
    
    func childRemove(_ child: Coordinator?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
    
}
