//
//  UIViewController + setMenuButton.swift
//  fmh
//
//  Created: 27.05.2022
//

import UIKit

extension UIViewController {
    
    func setMenuButton() {
        var menuImageString = "line.horizontal.3"
        if #available(iOS 15.0, *) {
            menuImageString = "line.3.horizontal"
        }
        
        let menuButton = UIBarButtonItem(image: UIImage(systemName: menuImageString),
                                         style: .done,
                                         target: self.revealViewController(),
                                         action: #selector(self.revealViewController()?.revealSideMenu))

         navigationItem.leftBarButtonItem = menuButton
    }
    
}
