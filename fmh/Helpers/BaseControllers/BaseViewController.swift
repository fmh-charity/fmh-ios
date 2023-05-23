//
//  BaseViewController.swift
//  fmh
//
//  Created: 26.11.2022
//

import UIKit

class BaseViewController: UIViewController, Presentable {
    
    var onCompletion: (() -> Void)?
    
    private(set) var args: [String:Any] = [:]
    
    init(_ args: [String: Any] = [:]) {
        self.args = args
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
