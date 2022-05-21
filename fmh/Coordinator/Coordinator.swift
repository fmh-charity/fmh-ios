//
//  Coordinator.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation
import UIKit

protocol Coordinator : AnyObject {
   
    var childCoordinators: [Coordinator] { get set }

    func start()
}
