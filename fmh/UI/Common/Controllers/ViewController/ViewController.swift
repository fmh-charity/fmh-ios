//
//  ViewController.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation
import UIKit

protocol ViewControllerProtocol: Presentable {
    var onCompletion : (() -> Void)? { get set }
}

// MARK: - BaseViewController

class ViewController: UIViewController, ViewControllerProtocol {
    
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
