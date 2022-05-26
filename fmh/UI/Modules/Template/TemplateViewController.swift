//
//  TemplateViewController.swift
//  fmh
//
//  Created: 25.05.2022
//

import Foundation
import UIKit

class TemplateViewController: UIViewController {
    
    var presenter: TemplatePresenterInput?
    
    weak var delegate: TemplateViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Template View Controller \(String(describing: (1...100).randomElement()))"

        // TODO: Перенести в отдельный класс или добавить в GeneralMenuViewController и от туда тянуть дочерними
        var menuImageString = "line.horizontal.3"
        if #available(iOS 15.0, *) {
            menuImageString = "line.3.horizontal"
        }
        
        let menuButton = UIBarButtonItem(image: UIImage(systemName: menuImageString),
                                         style: .done,
                                         target: revealViewController(),
                                         action: #selector(self.revealViewController()?.revealSideMenu))

        navigationItem.leftBarButtonItem = menuButton

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
