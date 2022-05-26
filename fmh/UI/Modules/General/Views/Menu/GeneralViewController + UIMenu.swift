//
//  GeneralViewController + UIMenu.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation
import UIKit

extension GeneralViewController {
    
    func uiMenu () -> UIMenu {
        return UIMenu(title: "", children: [
            UIAction(title: "News", handler: { [unowned self] _ in
                self.showViewController(viewController: UIViewController())
            }),
            UIAction(title: "Other", handler: { [unowned self] _ in
                self.showViewController(viewController: UIViewController())
            })
        ])
    }
    
}
