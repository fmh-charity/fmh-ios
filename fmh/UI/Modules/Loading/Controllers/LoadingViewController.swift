//
//  LoadingViewController.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation
import UIKit

class LoadingViewController: UIViewController {

    var presenter: LoadingPresenterInput?
    
    weak var delegate: LoadingViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Loading"
        
        commonInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.isDisplayed()
    }

}

// MAR: - Common Initilization
extension LoadingViewController {
    private func commonInit() {
        self.view.backgroundColor = .orange
    }
}

// MARK: - EnterPresenterOutput
extension LoadingViewController: LoadingPresenterOutput {
    func hide() {
        delegate?.onCompletion()
    }
}
