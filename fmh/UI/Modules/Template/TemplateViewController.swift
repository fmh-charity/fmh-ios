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
    
    /// Нужны для отключения свайпа (Открытия меню)
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.revealViewController()?.gestureEnabled = false
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.revealViewController()?.gestureEnabled = true
//    }
     
}

// MARK: - TemplatePresenterOutput
extension TemplateViewController: TemplatePresenterOutput {

}
