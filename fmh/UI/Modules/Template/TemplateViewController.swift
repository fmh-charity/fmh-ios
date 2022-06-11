//
//  TemplateViewController.swift
//  fmh
//
//  Created: 25.05.2022
//

import UIKit

class TemplateViewController: UIViewController, TemplateViewControllerProtocol {
    
    var presenter: TemplatePresenterInput?
    var onCompletion: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Template View Controller \(String(describing: (1...100).randomElement()))"

        setNavigationBarMenuButton()
        setNavigationBarLogo()
        setNavigationBarRightButtons()
    }
    
}

// MARK: - TemplatePresenterOutput
extension TemplateViewController: TemplatePresenterOutput {

}
