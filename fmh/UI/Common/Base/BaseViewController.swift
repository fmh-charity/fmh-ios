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
    
    private(set) var args: [String:Any] = [:]
    
    init(_ args: [String:Any] = [:]) {
        self.args = args
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
}
