//
//  GeneralViewController + UIAlertController.swift
//  fmh
//
//  Created: 15.05.2022
//

import Foundation
import UIKit

extension GeneralViewController {
    
    func alertActionMenu() -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Новости", style: .default , handler:{ [unowned self] _ in
            self.showViewController(viewController: UIViewController())
        }))
        
        alert.addAction(UIAlertAction(title: "Заявки", style: .default , handler:{ [unowned self] _ in
            self.showViewController(viewController: UIViewController())
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler:{ _ in }))
        
        return alert
    }
    
    func alertActionUser() -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Выйти", style: .default , handler:{ [unowned self] _ in
            self.presenter?.logOut()
            self.delegate?.logOut()
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler:{ _ in }))
        
        /// View for Current User
//        let view = UIView()
//        view.backgroundColor = .green
//        alert.view.addSubview(view)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            view.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 10),
//            view.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 10),
//            view.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -10),
//            view.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -10)
//        ])
//        alert.view.translatesAutoresizingMaskIntoConstraints = false
//        alert.view.heightAnchor.constraint(equalToConstant: 430).isActive = true
        
        
        
        return alert
    }
    
}
