//
//  PresentableProtocol.swift
//  fmh
//
//  Created: 27.05.2022
//

import UIKit

protocol PresentableProtocol {
    var toPresent: UIViewController { get }
}

// MARK: - Presentable
extension UIViewController: PresentableProtocol {
    
    var toPresent: UIViewController {
        return self
    }
    
    // TODO: Добавить методы: ShowAlert and ...
    
}
