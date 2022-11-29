//
//  BaseCoordinator.swift
//  fmh
//
//  Created: 23.11.2022
//

import Foundation

protocol Coordinatable : AnyObject {
//    var childCoordinators: [Coordinatable] { get set }
//    var onCompletion: CompletionBlock? { get set }
    
    func start()
}


//MARK: - BaseCoordinator
class BaseCoordinator: Coordinatable {
    
    var childCoordinators = [Coordinatable]()
    var onCompletion: (() -> ())?
    
    func start() {
        fatalError("CoordinatorBase: Need override in heir coordinator.")
    }
    
    func childAppend(_ child: Coordinatable) {
        for element in childCoordinators {
            if element === child { return }
        }
        childCoordinators.append(child)
    }
    
    func childRemove(_ child: Coordinatable?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
    
}
