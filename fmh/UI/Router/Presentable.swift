//
//  Presentable.swift
//  fmh
//
//  Created: 22.05.2023
//

import UIKit

protocol Presentable: AnyObject {
    var toPresent: UIViewController { get }
}

// MARK: - Default

extension Presentable where Self: UIViewController {
    var toPresent: UIViewController { return self }
}
