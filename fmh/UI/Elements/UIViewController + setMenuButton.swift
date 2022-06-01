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
        let view = UIView()
        let imageLogo = UIImageView()
        imageLogo.image = UIImage(named: "Logo")
        imageLogo.contentMode = .scaleAspectFit
        
        view.addSubview(imageLogo)
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageLogo.topAnchor.constraint(equalTo: view.topAnchor),
            imageLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageLogo.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4),
            imageLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
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
