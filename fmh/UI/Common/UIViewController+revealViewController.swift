//
//  UIViewController+revealViewController.swift
//  fmh
//
//  Created: 11.06.2022
//

import UIKit

//MARK: - revealViewController
extension UIViewController {
    
    func revealViewController() -> GeneralViewController? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is GeneralViewController {
            return viewController! as? GeneralViewController
        }
        while (!(viewController is GeneralViewController) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is GeneralViewController {
            return viewController as? GeneralViewController
        }
        return nil
    }
    
}
