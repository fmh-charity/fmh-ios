//
//  BaseViewController.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation
import UIKit

typealias NeedExecuteBlock = (_ params: [String : Any] ) -> Void

protocol BaseViewControllerProtocol: Presentable {
    var onCompletion : CompletionBlock? { get set }
    var needExecute : NeedExecuteBlock? { get set }
}


//MARK: - BaseViewController
class BaseViewController: UIViewController, BaseViewControllerProtocol {
    var onCompletion: CompletionBlock?
    var needExecute : NeedExecuteBlock?
}

//MARK: - alerts ...
extension BaseViewController {
    
}
