//
//  GeneralViewController + UIElements.swift
//  fmh
//
//  Created: 14.05.2022
//

import UIKit


extension GeneralViewController {
    
    func createTitleview() -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 150, height: 44)
        
        let imageLogo = UIImageView()
        imageLogo.image = UIImage(named: "logo")
        imageLogo.frame = .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 4)
        imageLogo.contentMode = .scaleAspectFit
        
        view.addSubview(imageLogo)
        
        return view
    }
    
    func createBattonItem(image: UIImage?, selector: Selector?) -> UIBarButtonItem {
        
        let barBattonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: selector)
       
        barBattonItem.tintColor = .white
        
        return barBattonItem
    }
    
}
