//
//  UIViewController+Alerts.swift
//  fmh
//
//  Created: 04.04.2023
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithAction(title: String? = nil, message: String, actionTitle: String, cancelActionTitle: String = "Отмена", actionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelActionTitle, style: .cancel))
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: actionHandler))
        self.present(alert, animated: true, completion: nil)
    }
}
