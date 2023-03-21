//
//  ViewController+Alerts.swift
//  fmh
//
//  Created: 14.03.2023
//

import UIKit

extension ViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
