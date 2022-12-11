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
}

//MARK: - alerts ...
extension BaseViewController {
    
}
