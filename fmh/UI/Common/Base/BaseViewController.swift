//
//  BaseViewController.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation
import UIKit

protocol BaseViewControllerProtocol: Presentable {
    var onCompletion : (() -> Void)? { get set }
}


//MARK: - BaseViewController
class BaseViewController: UIViewController, BaseViewControllerProtocol {
    var onCompletion: (() -> Void)?
    
    // По умолчание на всех экранах.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
}

//MARK: - alerts ...
extension BaseViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    func showDeleteAlert(title: String, message: String, onConfirm: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { (_) in
            onConfirm()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alert, animated: true)
    }
    
}
