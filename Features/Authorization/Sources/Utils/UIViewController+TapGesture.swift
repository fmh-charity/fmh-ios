//
//  File.swift
//  
//
//  Created by Константин Туголуков on 21.08.2023.
//

import UIKit

extension UIViewController {
    
    func addTapGestureForKeyboardHide() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewEndEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func viewEndEditing() {
        view.endEditing(true)
    }
}
