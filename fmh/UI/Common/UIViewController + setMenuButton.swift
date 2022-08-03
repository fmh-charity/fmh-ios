//
//  UIViewController + setMenuButton.swift
//  fmh
//
//  Created: 27.05.2022
//

import UIKit

extension UIViewController {
    
    func setNavigationBarMenuButton() {

        let menuButton = UIBarButtonItem(image: UIImage(named: "Menu"),
                                         style: .done,
                                         target: self.revealViewController(),
                                         action: #selector(self.revealViewController()?.revealSideMenu))

         navigationItem.leftBarButtonItem = menuButton
    }
    
}

extension UIViewController {
    
    func setNavigationBarLogo() {
        let view = UIView(frame: .init(x: 0, y: 0, width: 144, height: 44))

        let imageLogo = UIImageView(frame: .init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height-4))
        imageLogo.image = UIImage(named: "logo")
        imageLogo.contentMode = .scaleAspectFit

        view.addSubview(imageLogo)
  
        navigationItem.titleView = view
       
    }
    
}

extension UIViewController {
    
    func setNavigationBarRightButtons() {

        let ourMissionButton = UIBarButtonItem(image: UIImage(named: "Butterfly.white"),
                                         style: .done,
                                         target: self.revealViewController(),
                                         action: #selector(self.revealViewController()?.tapOurMissionButton))
        
        let userButton = UIBarButtonItem(image: UIImage(named: "User"),
                                         style: .done,
                                         target: self.revealViewController(),
                                         action: #selector(self.revealViewController()?.tapUserButton))

         navigationItem.rightBarButtonItems = [ourMissionButton, userButton]
    }
    
}
