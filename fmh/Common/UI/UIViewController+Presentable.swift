//
//  UIViewController+Presentable.swift
//  fmh
//
//  Created: 10.05.2022
//

import Foundation
import UIKit

extension UIViewController: Presentable {
    
    var toPresent: UIViewController? {
        return self
    }
    
    func showAlert(title: String, message: String? = nil) {
        UIAlertController.showAlert(title            : title,
                                    message          : message,
                                    inViewController : self,
                                    actionBlock      : nil)
    }
    
}
