//
//  BaseViewController.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation
import UIKit

protocol BaseViewControllerProtocol: Presentable {
    var onCompletion : CompletionBlock? { get set }
}


//MARK: - BaseViewController
class BaseViewController: UIViewController, BaseViewControllerProtocol {
    var onCompletion: CompletionBlock?
}

//MARK: - alerts ...
extension BaseViewController {
    
}
