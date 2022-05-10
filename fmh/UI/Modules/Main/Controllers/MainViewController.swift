//
//  MainViewController.swift
//  fmh
//
//  Created: 10.05.2022
//

import UIKit

class MainViewController: UIViewController, MainAssemblable {

    var presenter: MainPresenterInput?
    
    var onCompletion: CompletionBlock?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
    
        commonInit()
    }

}

// MAR: - Common Initilization
extension MainViewController {
    private func commonInit() {
        self.view.backgroundColor = .orange
    }
}

// MARK: - EnterPresenterOutput
extension MainViewController {
   
}
