//
//  GeneralContextViewController.swift
//  fmh
//
//  Created: 21.05.2022
//

import Foundation
import UIKit

protocol GeneralContextViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class GeneralContextViewController: UIViewController {
    
    weak var delegate: GeneralContextViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //title = "Context view controller"
        
        var menuImageString = "line.horizontal.3"
        if #available(iOS 15.0, *) {
            menuImageString = "line.3.horizontal"
        }
        
        let menuButton = UIBarButtonItem(image: UIImage(systemName: menuImageString),
                                         style: .done, target: self, action: #selector(menuTap))
        menuButton.tintColor = .white
        navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func menuTap() {
        delegate?.didTapMenuButton()
    }
    
}
